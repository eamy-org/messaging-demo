VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "ubuntu/trusty64"

    config.vm.define "zinc" do |zinc|

        zinc.vm.provision "shell" do |script|
            script.path = "provision/hostname.sh"
            script.args = "zinc"
        end

        zinc.vm.provision "shell", path: "provision/discovery.sh"
        zinc.vm.provision "shell", path: "provision/rabbitmq.sh"
        zinc.vm.provision "shell", path: "provision/mothership.sh"
        zinc.vm.provision "shell", run: "always" do |script|
            script.path = "provision/milery.sh"
            script.args = "zinc"
        end

        zinc.vm.network "private_network", ip: "192.168.33.10"
    end

    config.vm.define "iron" do |iron|

        iron.vm.provision "shell" do |script|
            script.path = "provision/hostname.sh"
            script.args = "iron"
        end

        iron.vm.provision "shell", path: "provision/discovery.sh"
        iron.vm.provision "shell", path: "provision/rabbitmq.sh"
        iron.vm.provision "shell" do |script|
            script.path = "provision/satelitte.sh"
            script.args = "iron"
        end

        iron.vm.provision "shell", run: "always" do |script|
            script.path = "provision/milery.sh"
            script.args = "iron"
        end

        iron.vm.network "private_network", ip: "192.168.33.11"
    end

    config.vm.define "gold" do |gold|

        gold.vm.provision "shell" do |script|
            script.path = "provision/hostname.sh"
            script.args = "gold"
        end

        gold.vm.provision "shell", path: "provision/discovery.sh"
        gold.vm.provision "shell", path: "provision/rabbitmq.sh"
        gold.vm.provision "shell" do |script|
            script.path = "provision/satelitte.sh"
            script.args = "gold"
        end

        gold.vm.provision "shell", run: "always" do |script|
            script.path = "provision/milery.sh"
            script.args = "gold"
        end

        gold.vm.network "private_network", ip: "192.168.33.12"
    end

end
