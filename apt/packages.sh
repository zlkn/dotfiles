
gitlab(){
  local VERSION="1.56.0"
  curl -L https://gitlab.com/gitlab-org/cli/-/releases/v1.56.0/downloads/glab_${VERSION}_linux_amd64.deb -o /tmp/glab.deb
  apt install -f /tmp/glab.deb
}

wezterm(){
  curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
  echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
  apt update
  apt install wezterm
}

goland(){
  curl -s https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc | gpg --dearmor | sudo tee /usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg > /dev/null
  echo "deb [signed-by=/usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg] http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com any main" | sudo tee /etc/apt/sources.list.d/jetbrains-ppa.list > /dev/null
  apt update
  apt install goland
}

fish(){
  curl -fsSL https://download.opensuse.org/repositories/shells:fish/Debian_12/Release.key | gpg --dearmor | sudo tee /usr/share/keyrings/fish.pgp > /dev/null
  echo 'deb [signed-by=/usr/share/keyrings/fish.pgp] http://download.opensuse.org/repositories/shells:/fish/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/shells:fish.list
  apt update
  apt install fish
}

kubectl(){
  apt update
  apt install -y apt-transport-https ca-certificates curl
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /usr/share/keyrings/kubernetes-apt-keyring.gpg
  echo 'deb [signed-by=/usr/share/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
  apt update
  apt install -y kubectl
}

gcloud(){
  apt-get install -y apt-transport-https ca-certificates gnupg curl
  apt-get update
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  apt-get install google-cloud-cli google-cloud-sdk-gke-gcloud-auth-plugin
  # gcloud container clusters list
  # gcloud container clusters get-credentials us --region=us-central1
}

hashicorp(){
  apt-get update && sudo apt-get install -y gnupg software-properties-common
  wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
  gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  apt update && sudo apt-get install terraform
}

docker(){
  apt-get update
  apt-get install ca-certificates curl
  curl -fsSL https://download.docker.com/linux/debian/gpg -o /usr/share/keyrings/docker.asc
  chmod a+r /usr/share/keyrings/docker.asc
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.asc] https://download.docker.com/linux/debian sid stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  apt-get update
  apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

gitlab
wezterm
fish
kubectl
gcloud
hashicorp


