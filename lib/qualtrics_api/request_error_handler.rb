require 'logger'

module QualtricsAPI
  class RequestErrorHandler < Faraday::Response::Middleware
    def on_complete(env)
      raise_http_errors(env[:status], env[:body])
      show_notices(env[:body])
    end

    private

    def raise_http_errors(code, body)
      case code
      when 400
        raise BadRequestError, error_message(JSON.parse(body))
      when 401
        raise UnauthorizedError, error_message(JSON.parse(body))
      when 403
        raise ForbiddenError, error_message(JSON.parse(body))
      when 404
        raise NotFoundError, error_message(JSON.parse(body))
      when 409
        raise ConflictError, error_message(JSON.parse(body))
      when 413
        raise RequestEntityTooLargeError, error_message(JSON.parse(body))
      when 414
        raise URITooLongError, error_message(JSON.parse(body))
      when 415
        raise UnsupportedMediaTypeError, error_message(JSON.parse(body))
      when 429
        raise TooManyRequestsError, error_message(JSON.parse(body))
      when 500
        raise InternalServerError, error_message(JSON.parse(body))
      when 503
        raise TemporaryInternalServerError, error_message(JSON.parse(body))
      when 504
        raise GatewayTimeoutError, error_message(JSON.parse(body))
      end
    end

    def show_notices(body)
      response = JSON.parse(body)
      notice = response["meta"]["notice"]
      if notice && notice.size > 0
        STDERR.puts notice
      end
    end

    def error_message(response)
      meta = response["meta"]
      err = meta["error"] || {}
      ["[",
      meta["status"] || meta["httpStatus"],
      " - ",
      err["qualtricsErrorCode"] || err["internalErrorCode"] || err["errorCode"],
       "] ",
       err["errorMessage"]
      ].join
    end
  end

  # HTTP Reponse Status Errors
  class BadRequestError < StandardError; end
  class UnauthorizedError < StandardError; end
  class ForbiddenError < StandardError; end
  class NotFoundError < StandardError; end
  class ConflictError < StandardError; end
  class RequestEntityTooLargeError < StandardError; end
  class URITooLongError < StandardError; end
  class UnsupportedMediaTypeError < StandardError; end
  class TooManyRequestsError < StandardError; end
  class InternalServerError < StandardError; end
  class TemporaryInternalServerError < StandardError; end
  class GatewayTimeoutError < StandardError; end

  # Application errors
  class NotSupported < StandardError; end
  class FileNotReadyError < StandardError; end
end
