# See if we need to check GIT for updates
    # Stash any local changes to the base files
    git stash > /dev/null 2>&1
    printf "Updating your local copy of Mediabox.\\n\\n"
    # Pull the latest files from Git
    git pull
    # Check to see if this script "prep.sh" was updated and restart it if necessary
    changed_files="$(git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD)"
    check_run() {
        echo "$changed_files" | grep --quiet "$1" && eval "$2"
    }
    # Provide a message once the Git check/update  is complete
    if [ -z "$changed_files" ]; then
        printf "Your Mediabox is current - No Update needed.\\n\\n"
    else
        printf "Mediabox Files Update complete.\\n\\nThis script will restart if necessary\\n\\n"
    fi
    # Rename the .env file so this check fails if mediabox.sh needs to re-launch
    mv .env 1.env
    read -r -p "Press any key to continue... " -n1 -s
    printf "\\n\\n"
    # Run exec mediabox.sh if mediabox.sh changed
    check_run mediabox.sh "exec ./prep.sh"


sudo useradd -m plex -u 1000 -g 1000

sudo echo castleredTuesday6! | passwd plex --stdin

sudo apt update && sudo apt full-upgrade
sudo apt install curl git bridge-utils
sudo apt remove docker docker-engine docker.io containerd runc
sudo snap remove docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo curl -s https://api.github.com/repos/docker/compose/releases/latest | grep "browser_download_url" | grep -i -m1 `uname -s`-`uname -m` | cut -d '"' -f4 | xargs sudo curl -L -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose -v
 sudo usermod -aG docker plex
