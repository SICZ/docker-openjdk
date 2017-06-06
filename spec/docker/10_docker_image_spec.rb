# encoding: UTF-8
require "docker_helper"

describe "Package" do
  [
    "bash",
    "java-1.8.0-openjdk-headless",
  ].each do |package|
    context package do
      it "is installed" do
        expect(package(package)).to be_installed
      end
    end
  end
end

describe "Environment variable" do
  context "JAVA_HOME" do
    subject do
      command("${JAVA_HOME}/bin/java -version")
    end
    it "points to a valid Java directory" do
      expect(subject.exit_status).to eq(0)
    end
  end
  context "PATH" do
    subject do
      command("java -version")
    end
    it "contains path to Java command" do
      expect(subject.exit_status).to eq(0)
    end
  end
end

describe "Docker entrypoint file" do
  context "/docker-entrypoint.sh" do
    it "is installed" do
      expect(file("/docker-entrypoint.sh")).to exist
      expect(file("/docker-entrypoint.sh")).to be_file
      expect(file("/docker-entrypoint.sh")).to be_executable
    end
  end
  [
    "/docker-entrypoint.d/30-environment-certs.sh",
    "/docker-entrypoint.d/31-environment-java-certs.sh",
    "/docker-entrypoint.d/40-server-certs.sh",
    "/docker-entrypoint.d/41-java-certs.sh",
  ].each do |file|
    context file do
      it "is installed" do
        expect(file(file)).to exist
        expect(file(file)).to be_file
        expect(file(file)).to be_readable
      end
    end
  end
end
