require "spec_helper"

describe QualtricsAPI::DirectoryCollection do
  subject { described_class.new }

  describe "#[]" do
    it "raises NotSupported" do
      expect { subject["POOL_abc123"] }.to raise_exception(QualtricsAPI::NotSupported, "#[] is not supported for Directory objects.")
    end
  end

  describe "#find" do
    it "raises NotSupported" do
      expect { subject.find("POOL_abc123") }.to raise_exception(QualtricsAPI::NotSupported, "#find is not supported for Directory objects.")
    end
  end
end
