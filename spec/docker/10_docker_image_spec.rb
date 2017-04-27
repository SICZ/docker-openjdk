# encoding: UTF-8
require "docker_helper"

describe "Package" do
  [
    "bash",
    "openjdk8",
  ].each do |package|
    context package do
      it "is installed" do
        expect(package(package)).to be_installed
      end
    end
  end
end

describe "Docker entrypoint file" do
  context "/docker-entrypoint.sh" do
    it "has set permissions" do
      expect(file("/docker-entrypoint.sh")).to exist
      expect(file("/docker-entrypoint.sh")).to be_executable
    end
  end
  [
    "/docker-entrypoint.d/31-environment-java-certs.sh",
    "/docker-entrypoint.d/41-java-certs.sh",
  ].each do |file|
    context file do
      it "exists" do
        expect(file(file)).to exist
        expect(file(file)).to be_readable
      end
    end
  end
end
