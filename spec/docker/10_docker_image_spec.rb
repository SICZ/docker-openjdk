require "docker_helper"

### DOCKER_IMAGE ###############################################################

describe "Docker image", :test => :docker_image do
  # Default Serverspec backend
  before(:each) { set :backend, :docker }

  ### DOCKER_IMAGE #############################################################

  describe docker_image(ENV["DOCKER_IMAGE"]) do
    # Execute Serverspec commands locally
    before(:each) { set :backend, :exec }
    it { is_expected.to exist }
  end

  ### PACKAGES #################################################################

  describe "Packages" do

    # [package, version, installer]
    packages = []

    case ENV["BASE_IMAGE_OS"]
    when "alpine"
      packages += [
        [
          "openjdk#{ENV["OPENJDK_PRODUCT_VERSION"]}-jre-base",
          "#{ENV["OPENJDK_PRODUCT_VERSION"]}.#{ENV["OPENJDK_UPDATE_VERSION"]}",
        ],
      ]
      if ENV["OPENJDK_EDITION"] == "jdk" then
        packages += [
          [
            "openjdk#{ENV["OPENJDK_PRODUCT_VERSION"]}",
            "#{ENV["OPENJDK_PRODUCT_VERSION"]}.#{ENV["OPENJDK_UPDATE_VERSION"]}",
          ],
        ]
      end
    when "centos"
      packages += [
        [
          "java-1.#{ENV["OPENJDK_PRODUCT_VERSION"]}.0-openjdk-headless",
          "1.#{ENV["OPENJDK_PRODUCT_VERSION"]}.0.#{ENV["OPENJDK_UPDATE_VERSION"]}",
        ],
      ]
      if ENV["OPENJDK_EDITION"] == "jdk" then
        packages += [
          [
            "java-1.#{ENV["OPENJDK_PRODUCT_VERSION"]}.0-openjdk-devel",
            "1.#{ENV["OPENJDK_PRODUCT_VERSION"]}.0.#{ENV["OPENJDK_UPDATE_VERSION"]}",
          ],
        ]
      end
    end

    packages.each do |package, version, installer|
      describe package(package) do
        it { is_expected.to be_installed }                        if installer.nil? && version.nil?
        it { is_expected.to be_installed.with_version(version) }  if installer.nil? && ! version.nil?
        it { is_expected.to be_installed.by(installer) }          if ! installer.nil? && version.nil?
        it { is_expected.to be_installed.by(installer).with_version(version) } if ! installer.nil? && ! version.nil?
      end
    end
  end

  ### FILES ####################################################################

  describe "Files" do

    # [file, mode, user, group, [expectations], [matches]]
    files = [
      [
        "/docker-entrypoint.sh",
        755, "root", "root",
        [:be_file]
      ],
    ]

    case ENV["OPENJDK_EDITION"]
    when "jre"
      files += [
        [
          "/docker-entrypoint.d/37-java-environment.sh",
          644, "root", "root",
          [:be_file, :eq_sha256sum]],
        [
          "/docker-entrypoint.d/47-java-certs.sh",
          644, "root", "root",
          [:be_file, :eq_sha256sum]
        ],
      ]
    end

    case ENV["BASE_IMAGE_OS"]
    when "alpine"
      files += [
        [
          "/usr/lib/jvm/default-jvm/jre/lib/security/java.security",
          nil, nil,    nil,
          nil,
          [
            "^securerandom.source=file:/dev/urandom$",
            "^networkaddress.cache.ttl=10$",
          ],
        ],
        # Simple check of the OS family
        "/etc/alpine-release",
      ]
    when "centos"
      files += [
        [
          "/usr/lib/jvm/jre/lib/security/java.security",
          nil, nil,    nil,
          nil,
          [
            "^securerandom.source=file:/dev/urandom$",
            "^networkaddress.cache.ttl=10$",
          ],
        ],
        # Simple check of the OS family
        "/etc/centos-release",
      ]
    end

    files.each do |file, mode, user, group, expectations, matches|
      expectations ||= []
      context file(file) do
        it { is_expected.to exist }
        it { is_expected.to be_file }       if expectations.include?(:be_file)
        it { is_expected.to be_directory }  if expectations.include?(:be_directory)
        it { is_expected.to be_mode(mode) } unless mode.nil?
        it { is_expected.to be_owned_by(user) } unless user.nil?
        it { is_expected.to be_grouped_into(group) } unless group.nil?
        its(:sha256sum) do
          is_expected.to eq(
              Digest::SHA256.file("#{ENV["OPENJDK_EDITION"]}/rootfs/#{subject.name}").to_s
          )
        end if expectations.include?(:eq_sha256sum)
        if ! matches.nil? then
          context "content" do
            matches.each do |match|
              it { expect(subject.content).to match(/#{match}/) }
            end
          end
        end
      end


    end
  end

  ##############################################################################

end

################################################################################
