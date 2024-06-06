require 'logger'

module QualtricsAPI
  class RequestErrorHandler < Faraday::Response::Middleware
    HTTP_RESPONSE_ERROR_RANGE = 400..599

    def on_complete(env)
      raise_http_errors(env[:status], env[:body])
      show_notices(env[:body])
    end

    private

    def raise_http_errors(code, body)
      case code
      when 200, 202
        return
      else
        return unless HTTP_RESPONSE_ERROR_RANGE.include?(code)

        raise http_error_class(code), error_message(JSON.parse(body))
      end
    end

    def http_error_class(code)
      case code
      when 400
        BadRequestError
      when 401
        UnauthorizedError
      when 403
        ForbiddenError
      when 404
        NotFoundError
      when 409
        ConflictError
      when 413
        RequestEntityTooLargeError
      when 414
        URITooLongError
      when 415
        UnsupportedMediaTypeError
      when 429
        TooManyRequestsError
      when 500
        InternalServerError
      when 503
        TemporaryInternalServerError
      when 504
        GatewayTimeoutError
      else
        UnknownResponseError
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
  class UnknownResponseError < StandardError; end

  # Application errors
  class NotSupported < StandardError; end
  class FileNotReadyError < StandardError; end
end
