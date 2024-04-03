Install wezterm
https://wezfurlong.org/wezterm/install/linux.html#__tabbed_1_3

```shell
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install wezterm
```

Setup goland

```shell
curl -s https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc | gpg --dearmor | sudo tee /usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg] http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com any main" | sudo tee /etc/apt/sources.list.d/jetbrains-ppa.list > /dev/null
sudo apt update
sudo apt install goland
```

Setup fish
https://github.com/fish-shell/fish-shell?tab=readme-ov-file#packages-for-linux

```shell
echo 'deb http://download.opensuse.org/repositories/shells:/fish/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/shells:fish.list
curl -fsSL https://download.opensuse.org/repositories/shells:fish/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish.gpg > /dev/null
sudo apt update
sudo apt install fish
```

Install kubectl
https://kubernetes.io/docs/tasks/tools/

```shell
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl

# If the folder `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubectl
```

Install gcloud & gke-gcloud-auth-plugin
https://cloud.google.com/sdk/docs/install#deb
https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl#apt

```shell
sudo apt-get install apt-transport-https ca-certificates gnupg curl
sudo apt-get update

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get install google-cloud-cli google-cloud-sdk-gke-gcloud-auth-plugin

gcloud container clusters list
gcloud container clusters get-credentials us --region=us-central1
```
