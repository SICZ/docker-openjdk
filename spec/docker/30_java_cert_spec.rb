require "docker_helper"

### JAVA_CERTIFICATE #########################################################

describe "Java certificate", :test => :java_cert do
  # Default Serverspec backend
  before(:each) { set :backend, :docker }

  ### CONFIG ###################################################################

  ca_crt            = ENV["CA_CRT_FILE"]                || "/etc/ssl/certs/ca.crt"
  server_crt        = ENV["SERVER_CRT_FILE"]            || "/etc/ssl/certs/server.crt"

  truststore        = ENV["JAVA_TRUTSTORE_FILE"]        || "/etc/ssl/certs/truststore.jks"
  truststore_pwd    = ENV["JAVA_TRUTSTORE_PWD_FILE"]    || "/etc/ssl/certs/truststore.pwd"
  truststore_user   = ENV["JAVA_TRUTSTORE_FILE_USER"]   || "root"
  truststore_group  = ENV["JAVA_TRUTSTORE_FILE_GROUP"]  || "root"
  truststore_mode   = ENV["JAVA_TRUTSTORE_FILE_MODE"]   || 444

  keystore          = ENV["JAVA_KEYSTORE_FILE"]         || "/etc/ssl/private/keystore.jks"
  keystore_pwd      = ENV["JAVA_KEYSTORE_PWD_FILE"]     || "/etc/ssl/private/keystore.pwd"
  keystore_user     = ENV["JAVA_KEYSTORE_FILE_USER"]    || "root"
  keystore_group    = ENV["JAVA_KEYSTORE_FILE_GROUP"]   ||"root"
  keystore_mode     = ENV["JAVA_KEYSTORE_FILE_MODE"]    || 440

  ### TRUSTSTORE_PASSPHRASE ####################################################

  describe "Java truststore passphrase \"#{truststore_pwd}\"" do
    context "file" do
      subject { file(truststore_pwd) }
      it { is_expected.to be_file }
      it { is_expected.to be_mode(truststore_mode) }
      it { is_expected.to be_owned_by(truststore_user) }
      it { is_expected.to be_grouped_into(truststore_group) }
    end
  end

  ### TRUSTSTORE ###############################################################

  describe "Java truststore \"#{truststore}\"" do
    context "file" do
      subject { file(truststore) }
      it { is_expected.to be_file }
      it { is_expected.to be_mode(truststore_mode) }
      it { is_expected.to be_owned_by(truststore_user) }
      it { is_expected.to be_grouped_into(truststore_group) }
    end
    context "truststore" do
      # Get server certificate fingerprint
      let(:ca_crt_fingerprint) do
        Serverspec::Type::Command
        .new("openssl x509 -noout -fingerprint -sha1 -in #{ca_crt}")
        .stdout
        .sub(/^SHA1 Fingerprint=/, "")
        .strip
      end
      subject do
        command("keytool -list -keystore #{truststore} -storepass $(cat #{truststore_pwd})")
      end
      it "should be valid" do
        expect(subject.exit_status).to eq(0)
      end
      it "should be JKS type" do
        expect(subject.stdout).to match(/^Keystore type: JKS$/)
      end
      it "should contains CA certificate" do
        expect(subject.stdout).to match(/^ca.crt,/)
        expect(subject.stdout).to match(/^ca.crt,.*\btrustedCertEntry\b/)
        expect(subject.stdout).to match(/\nca.crt,[^\n]*\nCertificate fingerprint \(SHA1\): #{ca_crt_fingerprint}\n/m)
      end
      # TODO: Test certificate
    end
  end

  ### KEYSTORE_PASSPHRASE ######################################################

  describe "Java keystore passphrase \"#{keystore_pwd}\"" do
    context "file" do
      subject { file(keystore_pwd) }
      it { is_expected.to be_file }
      it { is_expected.to be_mode(keystore_mode) }
      it { is_expected.to be_owned_by(keystore_user) }
      it { is_expected.to be_grouped_into(keystore_group) }
    end
  end

  ### KEYSTORE #################################################################

  describe "Java keystore \"#{keystore}\"" do
    context "file" do
      subject { file(keystore) }
      it { is_expected.to be_file }
      it { is_expected.to be_mode(keystore_mode) }
      it { is_expected.to be_owned_by(keystore_user) }
      it { is_expected.to be_grouped_into(keystore_group) }
    end
    context "keystore" do
      # Get server certificate fingerprint
      let(:server_crt_fingerprint) do
        Serverspec::Type::Command
        .new("openssl x509 -noout -fingerprint -sha1 -in #{server_crt}")
        .stdout
        .sub(/^SHA1 Fingerprint=/, "")
        .strip
      end
      subject do
        command("keytool -list -keystore #{keystore} -storepass $(cat #{keystore_pwd})")
      end
      it "should be valid" do
        expect(subject.exit_status).to eq(0)
      end
      it "should be JKS type" do
        expect(subject.stdout).to match("Keystore type: JKS")
      end
      it "should contains server certificate and private key" do
        expect(subject.stdout).to match(/^server.crt,/)
        expect(subject.stdout).to match(/^server.crt,.*\bPrivateKeyEntry\b/)
        expect(subject.stdout).to match(/\nserver.crt,[^\n]*\nCertificate fingerprint \(SHA1\): #{server_crt_fingerprint}\n/m)
      end
      # TODO: test certificate
      # TODO: test key
    end
  end

  ##############################################################################

end

################################################################################
