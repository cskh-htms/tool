#!/bin/bash

BASHRC="$HOME/.bashrc"
ALIASES_FILE="$HOME/.bash_aliases"

echo "👉 Đang setup aliases..."

# 1. Ghi đè toàn bộ file ~/.bash_aliases
cat > "$ALIASES_FILE" <<'EOF'
#
# git  -----------------------------------------
alias llat='sudo chmod -R +x ./tool*'
alias lla='rm -rf ./tool && git clone git@github.com:cskh-htms/tool.git && find ./tool -type f -name "*.sh" -exec chmod +x {} \;'

alias llaa='rm -rf ./tool && git clone https://github.com/cskh-htms/tool.git && find ./tool -type f -name "*.sh" -exec chmod +x {} \;'



alias llaht='rm -rf ./tool-htms && git clone git@github.com:cskh-htms/tool-htms.git && find ./tool-htms -type f -name "*.sh" -exec chmod +x {} \;'
alias llads='rm -rf ./tool-diem-sac && git clone git@github.com:cskh-htms/tool-diem-sac.git && find ./tool-diem-sac -type f -name "*.sh" -exec chmod +x {} \;'
alias llaxd='rm -rf ./tool-xanh-demo && git clone git@github.com:cskh-htms/tool-xanh-demo.git && find ./tool-xanh-demo -type f -name "*.sh" -exec chmod +x {} \;'

alias llamo='rm -rf ./htms_minio && git clone git@github.com:cskh-htms/htms_minio.git && find ./htms_minio -type f -name "*.sh" -exec chmod +x {} \;'
alias llamnt='rm -rf ./htms_monitor && git clone git@github.com:cskh-htms/htms_monitor.git && find ./htms_monitor -type f -name "*.sh" -exec chmod +x {} \;'

alias llamnol='rm -rf ./tool-minio-live && git clone git@github.com:cskh-htms/tool-minio-live.git && find ./tool-minio-live -type f -name "*.sh" -exec chmod +x {} \;'

alias llagp='rm -rf ./tool-gpmb && git clone git@github.com:cskh-htms/tool-gpmb.git && find ./tool-gpmb -type f -name "*.sh" -exec chmod +x {} \;'
alias lladt='rm -rf ./tool-dtc && git clone git@github.com:cskh-htms/tool-dtc.git && find ./tool-dtc -type f -name "*.sh" -exec chmod +x {} \;'

alias llagr='rm -rf ./tool-greeneco && git clone git@github.com:cskh-htms/tool-greeneco.git && find ./tool-greeneco -type f -name "*.sh" -exec chmod +x {} \;'
alias llatt='rm -rf ./tool-thoitrang && git clone git@github.com:cskh-htms/tool-thoitrang.git && find ./tool-thoitrang -type f -name "*.sh" -exec chmod +x {} \;'
alias lladm='rm -rf ./tool-demo && git clone git@github.com:cskh-htms/tool-demo.git && find ./tool-demo -type f -name "*.sh" -exec chmod +x {} \;'
alias llacf='rm -rf ./tool-cafe && git clone git@github.com:cskh-htms/tool-cafe.git && find ./tool-cafe -type f -name "*.sh" -exec chmod +x {} \;'
alias llatp='rm -rf ./tool-tpdn && git clone git@github.com:cskh-htms/tool-tpdn.git && find ./tool-tpdn -type f -name "*.sh" -exec chmod +x {} \;'
alias lladh='rm -rf ./tool-daihung && git clone git@github.com:cskh-htms/tool-daihung.git && find ./tool-daihung -type f -name "*.sh" -exec chmod +x {} \;'
alias llamd='rm -rf ./tool-minhdang && git clone git@github.com:cskh-htms/tool-minhdang.git && find ./tool-minhdang -type f -name "*.sh" -exec chmod +x {} \;'
alias llapdf='rm -rf ./tool-pdf && git clone git@github.com:cskh-htms/tool-pdf.git && find ./tool-pdf -type f -name "*.sh" -exec chmod +x {} \;'
alias llat3='rm -rf ./tool-t3s && git clone git@github.com:cskh-htms/tool-t3s.git && find ./tool-t3s -type f -name "*.sh" -exec chmod +x {} \;'
alias llabr='rm -rf ./tool-browser && git clone git@github.com:cskh-htms/tool-browser.git && find ./tool-browser -type f -name "*.sh" -exec chmod +x {} \;'
alias llaws='rm -rf ./tool-website && git clone git@github.com:cskh-htms/tool-website.git && find ./tool-website -type f -name "*.sh" -exec chmod +x {} \;'
alias llasks='rm -rf ./tool-skins && git clone git@github.com:cskh-htms/tool-skins.git && find ./tool-skins -type f -name "*.sh" -exec chmod +x {} \;'

alias llaep='rm -rf ./tool-epacvn && git clone git@github.com:cskh-htms/tool-epacvn.git && find ./tool-epacvn -type f -name "*.sh" -exec chmod +x {} \;'
alias llatr='rm -rf ./tool-trial && git clone git@github.com:cskh-htms/tool-trial.git && find ./tool-trial -type f -name "*.sh" -exec chmod +x {} \;'
alias llast='rm -rf ./tool-store && git clone git@github.com:cskh-htms/tool-store.git && find ./tool-store -type f -name "*.sh" -exec chmod +x {} \;'
alias llatpl='rm -rf ./tool-template && git clone git@github.com:cskh-htms/tool-template.git && find ./tool-template -type f -name "*.sh" -exec chmod +x {} \;'
alias llamt='rm -rf ./tool-maytinh && git clone git@github.com:cskh-htms/tool-maytinh.git && find ./tool-maytinh -type f -name "*.sh" -exec chmod +x {} \;'






#
#
#
# setup vps
alias llastus='./tool/vps/create_user_one_htms.sh'
alias llastbm='./tool/vps/setup-security.sh'
alias llastat='./tool/vps/install-all-tools.sh'
alias llastdk='./tool/vps/install-docker.sh'
alias llastng='./tool/vps/install-nginx.sh'
alias llastsw='bash ./tool/vps/setup-new-vps.sh --swap-only'
alias llastf2='./tool/vps/cau-hinh-fail2ban-ssh-23266.sh'
alias llasta='bash ./tool/vps/setup-new-vps.sh'







# ------------------------
# git copy ca hinh moi khi thay doi thme hoat bot repo 
# khi chay no thi se reload lai copy len vps va reload lai
alias llagitbk='mkdir -p /home/user_one_htms/scripts && sudo cp /home/user_one_htms/tool-htms/scripts/backup-all-repo-git.sh /home/user_one_htms/scripts/backup-all-repo-git.sh'


#
# alias view ---------------------------------------------------
llah() {
    alias | grep -F -- "$*"
}
alias llar='./tool/vps/setup-alias.sh'
alias llal='cat ~/.bash_aliases'
alias llac='nano ~/.bash_aliases'
alias llas='source ~/.bash_aliases'
alias llars='unalias llah 2>/dev/null'



#
# backup ---------------------------------------------------
alias llabkc='mkdir -p /home/user_one_htms/scripts && sudo cp /home/user_one_htms/tool-htms/scripts/backup-all-repo-git.sh /home/user_one_htms/scripts/backup-all-repo-git.sh'



#
# cron ---------------------------------------------------
alias llacron='crontab -e'
alias llacrol='tail -n 50 -f /home/user_one_htms/logs/cron.log'


#
# test vps ---------------------------------------------------
alias llavpsc='sudo bash "$HOME/tool/vps/test-cpu.sh"'
alias llavpsr='sudo bash "$HOME/tool/vps/test-ram.sh"'
alias llavpsn='sudo bash "$HOME/tool/vps/test-mang.sh"'
alias llavpsd='sudo bash "$HOME/tool/vps/test-io.sh"'
#
#
#
# nginx
alias llangxsa='sudo ls /etc/nginx/sites-available'
alias llangxse='sudo ls /etc/nginx/sites-enabled'
alias llangxs='sudo systemctl status nginx'
alias llangxrs='sudo systemctl restart nginx'
alias llangxt='sudo nginx -t'
llangxn() {
    sudo nano "/etc/nginx/sites-available/$1"
}





# cache 
# llachs - Kiem tra Cloudflare Cache
# Su dung: llachs htms.vn
#          llachs htms.vn/images/banner.webp
# ==================================================

llachs() {
    local url="${1:?Usage: llachs domain.com}"

    # Tu dong them https:// neu chua co
    [[ "$url" =~ ^https?:// ]] || url="https://$url"

    echo "URL: $url"
    echo "--------------------------------"

    for i in 1 2 3; do
        echo "===== LAN $i ====="

        curl -sSI -L --max-time 15 "$url" \
            | grep -iE '^(HTTP/|server:|cf-cache-status:|cache-control:|age:)'

        sleep 2
    done
}






#
#
#
# telegram
alias llatlgc='mkdir -p telegram && nano ./telegram/.env.telegram'
alias llatlgn='nano ./telegram/.env.telegram'
alias llatlgp='chmod 644  ./telegram/.env.telegram'


#
#
#
# s3
alias llas3c='mkdir -p s3 && nano ./s3/.env.s3'
alias llas3n='nano ./s3/.env.s3'
alias llas3p='chmod 644  ./s3/.env.s3'




#
#
#
# cloudfly
alias llaclfc='mkdir -p cloudfly && nano ./cloudfly/.env.cloudfly'
alias llaclfn='nano ./cloudfly/.env.cloudfly'
alias llaclfp='chmod 644  ./cloudfly/.env.cloudfly'


#
#
#
# ip
alias llaips='curl -4 https://api.ipify.org; echo'




#
#
#
# vps - key-user  ---tat mo dang nhap bang password , tat mo cho phep root dan gnhap--------------------------------------
alias llapd='printf "%s\n" "PasswordAuthentication no" "KbdInteractiveAuthentication no" "PubkeyAuthentication yes" | sudo tee /etc/ssh/sshd_config.d/00-disable-password.conf >/dev/null && sudo chmod 644 /etc/ssh/sshd_config.d/00-disable-password.conf && sudo sshd -t && sudo systemctl reload ssh && sudo sshd -T | grep -E "^(permitrootlogin|pubkeyauthentication|passwordauthentication|kbdinteractiveauthentication|usepam) "'
alias llape='printf "%s\n" "PasswordAuthentication yes" "KbdInteractiveAuthentication no" "PubkeyAuthentication yes" | sudo tee /etc/ssh/sshd_config.d/00-disable-password.conf >/dev/null && sudo chmod 644 /etc/ssh/sshd_config.d/00-disable-password.conf && sudo sshd -t && sudo systemctl reload ssh && sudo sshd -T | grep -E "^(permitrootlogin|pubkeyauthentication|passwordauthentication|kbdinteractiveauthentication|usepam) "'
alias llard='(sudo grep -q "^PermitRootLogin" /etc/ssh/sshd_config.d/50-cloud-init.conf && sudo sed -i "s/^PermitRootLogin .*/PermitRootLogin no/" /etc/ssh/sshd_config.d/50-cloud-init.conf || echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config.d/50-cloud-init.conf >/dev/null) && sudo sshd -t && sudo systemctl restart ssh && sudo sshd -T | grep -E "permitrootlogin|pubkeyauthentication|passwordauthentication|kbdinteractiveauthentication|challengeresponseauthentication|usepam"'
alias llare='printf "%s\n" "PermitRootLogin yes" | sudo tee /etc/ssh/sshd_config.d/00-root-login.conf >/dev/null && sudo chmod 644 /etc/ssh/sshd_config.d/00-root-login.conf && sudo sshd -t && sudo systemctl reload ssh && sudo sshd -T | grep -E "^(permitrootlogin|pubkeyauthentication|passwordauthentication|kbdinteractiveauthentication|usepam) "'
#alias llaka='_llakey them'
#alias llakd='_llakey xoa'


#
#
#
# ssh
alias llasshn='nano ./.ssh/authorized_keys'
alias llasshck='ssh-keygen -t ed25519 -a 100'
alias llasshvk='cat ./.ssh/id_ed25519'
alias llasshvp='cat ./.ssh/id_ed25519.pub'
alias llasshrl='sudo systemctl restart ssh'
alias llasshrs='sudo systemctl restart ssh'

#
#
#
# monitor
alias llamntn='sudo nano /etc/web-monitor/sites.txt'






#
# fail2ban---------------------------------------------------
alias llaf2bs='sudo systemctl status fail2ban'
alias llaf2bd='sudo systemctl stop fail2ban'
alias llaf2be='sudo systemctl start fail2ban'
alias llaf2bvb='sudo fail2ban-client get sshd banned'
llaf2bub() {
    local ip
    read -r -p "Nhập IP cần mở khóa: " ip
    if [[ -z "$ip" ]]; then
        echo "Bạn chưa nhập IP."
        return 1
    fi
    sudo fail2ban-client set sshd unbanip "$ip"
}

# fail2ban -----------------------------------
alias llafh='alias | grep "^alias llaf"'
alias llafa='sudo fail2ban-client status'
alias llafs='sudo fail2ban-client status sshd'
alias llafl='sudo tail -f /var/log/fail2ban.log'
alias llafla='sudo tail -f /var/log/auth.log'
alias llafr='sudo systemctl restart fail2ban'


#
# dns ------------------------------------------
# thay doi dns cua google
lladnsg() {
    sudo netplan set --origin-hint 50-cloud-init \
        'ethernets.eth0.nameservers=null' &&
    sudo netplan set --origin-hint 50-cloud-init \
        'ethernets.eth0.nameservers.addresses=[8.8.8.8,8.8.4.4]' &&
    sudo netplan generate &&
    sudo netplan try --timeout 120 &&
    sudo resolvectl flush-caches &&
    resolvectl status eth0
}
alias lladnsv='resolvectl status'




#
# logs --------------------------------------------
alias llalh='alias | grep "^alias llal"'
alias llala='journalctl -f'
alias llalb='journalctl -xe'
alias llals='sudo tail -f /var/log/syslog'
alias llalu='sudo tail -f /var/log/auth.log'

#
# users ---------------------------------------------
alias llausl='while read user; do echo "$user: $(groups $user)"; done < <(cut -d: -f1 /etc/passwd)'
alias llausvi="echo 'user_one_htms ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/user_one_htms-nopasswd >/dev/null && sudo chmod 440 /etc/sudoers.d/user_one_htms-nopasswd && sudo visudo -cf /etc/sudoers.d/user_one_htms-nopasswd"
alias llausp=


#
# groups -----------------------------------------
alias llagh='alias | grep "^alias llag"'
alias llagl='getent group'

#
# dist --------------------------------------------
alias lladl='df -h --total | grep total'
alias lladf='df -h --total | grep total'
alias llada='sudo du -h --max-depth=1 / | sort -hr'
alias lladb='sudo du -h --max-depth=1 /var | sort -hr'

lladd() {
  sudo du -h --max-depth=1 "${1:-/}" | sort -hr
}

lladdm() {
  sudo find "${1:-/}" -type f -printf '%s\t%p\n' 2>/dev/null \
    | sort -nr \
    | head -n 5 \
    | awk '{size=$1; $1=""; sub(/^\t? */, ""); cmd="numfmt --to=iec --suffix=B " size; cmd | getline h; close(cmd); print h "\t" $0}'
}



#
# port --------------------------------------------
alias llaph='alias | grep "^alias llap"'
alias llapl='sudo ss -tulnp'






# mail -----------------------------------
alias llamh='alias | grep "^alias llam"'
alias llaml='sudo docker exec -it mailserver setup email list'
alias llamc='sudo nano /opt/mailserver/.env'
alias llamr='docker restart mailserver'
alias llamlo='docker logs -f mailserver'




#
# docker: --------------------------------------------
alias lladkh='alias | grep "^alias lladk"'
alias lladkc='docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias lladks='docker ps --format "table {{.Label \"com.docker.compose.project\"}}\t{{.Label \"com.docker.compose.service\"}}\t{{.Status}}"'
alias lladkdf='docker system df'
alias lladkdfv='docker system df -v'
alias lladkp='docker system prune'
alias lladkpa='docker system prune -a'
alias lladkpaf='docker system prune -af'

alias lladkbpa='docker builder prune --all --force'
alias lladkbxpa='docker builder prune --all --force'

alias lladksta='docker ps -q | xargs -r docker stop'
alias lladkrsa='docker ps -aq | xargs -r docker start'

alias lladkdfi='docker image ls -aq --no-trunc \
  | sort -u \
  | xargs -r docker image inspect --format "{{.Size}}{{\"\t\"}}{{.Id}}{{\"\t\"}}{{join .RepoTags \",\"}}" \
  | sort -nr \
  | awk -F "\t" '\''
function shorten(text, limit) {
  return length(text) > limit ? substr(text, 1, limit - 3) "..." : text
}
BEGIN {
  printf "%-32s %10s  %-12s  %-18s\n", "TEN IMAGE", "DUNG LUONG", "IMAGE ID", "TAG"
}
{
  size = ($1 >= 1000000000) \
    ? sprintf("%.2f GB", $1 / 1000000000) \
    : sprintf("%.1f MB", $1 / 1000000)

  id = $2
  sub(/^sha256:/, "", id)
  id = substr(id, 1, 12)

  n = split($3, refs, ",")
  for (i = 1; i <= n; i++) {
    ref = refs[i]
    if (ref == "" || ref ~ /@sha256:/) continue
    match(ref, /:[^:]*$/)
    name = substr(ref, 1, RSTART - 1)
    tag = substr(ref, RSTART + 1)
    printf "%-32s %10s  %-12s  %-18s\n", shorten(name, 32), size, id, shorten(tag, 18)
  }
  if ($3 == "")
    printf "%-32s %10s  %-12s  %-18s\n", "<khong co ten>", size, id, "<none>"
}'\'''

#
# docker images--------------------------------------------
alias lladkimpaf='docker image prune -a -f'

_lladkdfv() {
python3 - <<'PY'
import json
import subprocess

def docker(*args):
    return subprocess.check_output(["docker", *args], text=True).strip()

ids = docker("ps", "-q").split()
if not ids:
    print("Không có container đang chạy.")
    raise SystemExit

volumes = {}
for container in json.loads(docker("inspect", *ids)):
    labels = container["Config"].get("Labels") or {}
    project = labels.get("com.docker.compose.project", "-")
    service = labels.get(
        "com.docker.compose.service", container["Name"].lstrip("/")
    )
    for mount in container.get("Mounts", []):
        if mount["Type"] == "volume":
            volumes.setdefault(mount["Name"], set()).add((project, service))

if not volumes:
    print("Không có volume gắn với container đang chạy.")
    raise SystemExit

names = sorted(volumes)
command = ["docker", "run", "--rm", "--network", "none"]
for index, name in enumerate(names):
    command += [
        "--mount",
        f"type=volume,src={name},dst=/volumes/{index},readonly"
    ]
command += [
    "alpine:3.22", "sh", "-c",
    'for d in /volumes/*; do du -sk "$d" || exit; done'
]

sizes = {}
for line in subprocess.check_output(command, text=True).splitlines():
    size, path = line.split(maxsplit=1)
    sizes[int(path.rsplit("/", 1)[1])] = int(size) * 1024

def human(size):
    for unit in ["B", "KiB", "MiB", "GiB", "TiB"]:
        if size < 1024 or unit == "TiB":
            return f"{size:.2f} {unit}"
        size /= 1024

print(f"{'TÊN VOLUME':<55} {'DUNG LƯỢNG':>13}  {'DỰ ÁN':<28} SERVICE")
for index in sorted(sizes, key=sizes.get, reverse=True):
    name = names[index]
    for project, service in sorted(volumes[name]):
        print(f"{name:<55} {human(sizes[index]):>13}  {project:<28} {service}")
PY
}
alias lladkdfv='_lladkdfv'

#
#
#
# docker volume--------------------------------------------
alias lladkvpa='docker volume prune --all'



#
#
# -----------------------------------------
_llakey() (
    action="$1"
    dir="$HOME/.ssh"
    file="$dir/authorized_keys"

    read -r -p "Nhap public key can $action: " key
    read -r type data _ <<< "$key"

    if [ -z "$type" ] || [ -z "$data" ]; then
        echo "Public key khong hop le."
        exit 1
    fi

    mkdir -p "$dir" && chmod 700 "$dir" || exit 1
    tmp="$(mktemp "$dir/.authorized_keys.XXXXXX")" || exit 1
    trap 'rm -f "$tmp"' EXIT

    # Kiem tra key truoc khi sua authorized_keys.
    printf '%s\n' "$key" > "$tmp"
    if ! ssh-keygen -lf "$tmp" >/dev/null 2>&1; then
        echo "Public key khong hop le."
        exit 1
    fi

    if [ ! -e "$file" ]; then
        if [ "$action" = "xoa" ]; then
            echo "Chua co file authorized_keys."
            exit 0
        fi
        touch "$file" || exit 1
    fi

    if [ -L "$file" ] || [ ! -f "$file" ]; then
        echo "authorized_keys phai la file thuong."
        exit 1
    fi

    # Nhan dien key ke ca khi dong co options hoac comment.
    if awk -v t="$type" -v d="$data" '
        /^[[:space:]]*#/ { next }
        {
            for (i = 1; i < NF; i++)
                if ($i == t && $(i+1) == d) found = 1
        }
        END { exit(found ? 0 : 1) }
    ' "$file"; then
        found=1
    else
        found=0
    fi

    if [ "$action" = "them" ] && [ "$found" = 1 ]; then
        echo "Key da ton tai; khong them trung."
        exit 0
    fi

    if [ "$action" = "xoa" ] && [ "$found" = 0 ]; then
        echo "Khong tim thay key; giu nguyen file."
        exit 0
    fi

    awk -v t="$type" -v d="$data" -v a="$action" -v k="$key" '
        {
            match_key = 0
            if ($0 !~ /^[[:space:]]*#/)
                for (i = 1; i < NF; i++)
                    if ($i == t && $(i+1) == d) match_key = 1

            if (a != "xoa" || !match_key) print
        }
        END {
            if (a == "them") print k
        }
    ' "$file" > "$tmp" || exit 1

    chmod 600 "$tmp" && mv -f "$tmp" "$file" || exit 1
    echo "Da $action key trong $file."
)

alias llaka='_llakey them'
alias llakd='_llakey xoa'






#
#
# tool-daihung:
alias lladhp='docker pull cskhhtms/daihung_web:deploy_latest'
alias lladhd='docker compose -p user_one_htms_daihung -f "$HOME/docker-compose-daihung-server.yml" up -d --no-deps web_daihung'
alias lladhsta='docker compose -p user_one_htms_daihung -f "$HOME/docker-compose-daihung-server.yml" up -d --no-deps web_daihung'
alias lladhdw='docker compose -p user_one_htms_daihung -f "$HOME/docker-compose-daihung-server.yml" down'
alias lladhdwv='docker compose -p user_one_htms_daihung -f "$HOME/docker-compose-daihung-server.yml" down -v'

alias lladhadlsto='sudo -u ubuntu -H bash /home/ubuntu/tool-daihung/scripts/disable-auditlog.sh'
alias lladhadlsta='sudo -u ubuntu -H bash /home/ubuntu/tool-daihung/scripts/enable-auditlog.sh'

alias lladhbktele='sudo -u ubuntu -H bash /home/ubuntu/scripts/daihung/backup-database-to-telegram.sh'
alias lladhbkclfl='sudo -u ubuntu -H bash /home/ubuntu/scripts/daihung/backup-uploads-to-cloudfly.sh'


alias lladhste='COMPOSE_FILE="${COMPOSE_FILE:-$HOME/docker-compose-daihung-server.yml}" DB_SERVICE="${DB_SERVICE:-db_daihung}" DB_CONTAINER="${DB_CONTAINER:-diem_sac_db_daihung}" DB_NAME="${DB_NAME:-diem_sac_db_daihung}" DB_USER="${DB_USER:-diem_sac_user_daihung}" ~/tool-daihung/scripts/daihung/export-structure-daihung-server.sh'
alias lladhdte='COMPOSE_FILE="${COMPOSE_FILE:-$HOME/docker-compose-daihung-server.yml}" DB_SERVICE="${DB_SERVICE:-db_daihung}" DB_CONTAINER="${DB_CONTAINER:-diem_sac_db_daihung}" DB_NAME="${DB_NAME:-diem_sac_db_daihung}" DB_USER="${DB_USER:-diem_sac_user_daihung}" ~/tool-daihung/scripts/daihung/export-datas-daihung-server.sh'







#
# tool-minhdang:
#
alias llamdp='docker pull cskhhtms/minhdang_web:deploy_latest'
alias llamdd='docker compose -p user_one_htms_minhdang -f "$HOME/docker-compose-minhdang-server.yml" up -d --no-deps web_minhdang'
alias llamdsta='docker compose -p user_one_htms_minhdang -f "$HOME/docker-compose-minhdang-server.yml" up -d --no-deps web_minhdang'
alias llamddw='docker compose -p user_one_htms_minhdang -f "$HOME/docker-compose-minhdang-server.yml" down'
alias llamddwv='docker compose -p user_one_htms_minhdang -f "$HOME/docker-compose-minhdang-server.yml" down -v'

alias llamdadlsto='sudo -u ubuntu -H bash /home/ubuntu/tool-minhdang/scripts/disable-auditlog.sh'
alias llamdadlsta='sudo -u ubuntu -H bash /home/ubuntu/tool-minhdang/scripts/enable-auditlog.sh'

alias llamdbktele='sudo -u ubuntu -H bash /home/ubuntu/scripts/minhdang/backup-database-to-telegram.sh'
alias llamdbkclfl='sudo -u ubuntu -H bash /home/ubuntu/scripts/minhdang/backup-uploads-to-cloudfly.sh'
alias llmdste='COMPOSE_FILE="${COMPOSE_FILE:-$HOME/docker-compose-minhdang-server.yml}" DB_SERVICE="${DB_SERVICE:-db_minhdang}" DB_CONTAINER="${DB_CONTAINER:-diem_sac_db_minhdang}" DB_NAME="${DB_NAME:-diem_sac_db_minhdang}" DB_USER="${DB_USER:-diem_sac_user_minhdang}" LOCAL_FILE="${LOCAL_FILE:-$HOME/datas/structure-md.sql}" ~/tool-daihung/scripts/daihung/export-structure-daihung-server.sh'
alias llmddte='COMPOSE_FILE="${COMPOSE_FILE:-$HOME/docker-compose-minhdang-server.yml}" DB_SERVICE="${DB_SERVICE:-db_minhdang}" DB_CONTAINER="${DB_CONTAINER:-diem_sac_db_minhdang}" DB_NAME="${DB_NAME:-diem_sac_db_minhdang}" DB_USER="${DB_USER:-diem_sac_user_minhdang}" LOCAL_FILE="${LOCAL_FILE:-$HOME/datas/data-md.sql}" ~/tool-daihung/scripts/daihung/export-datas-daihung-server.sh'


#
# tool-t3s:
#
alias llat3p='docker pull cskhhtms/minhdang_web:deploy_latest'
alias llat3d='docker compose -p ubuntu_t3s -f "$HOME/docker-compose-t3s-server.yml" up -d --no-deps web_t3s'
alias llat3sta='docker compose -p ubuntu_t3s -f "$HOME/docker-compose-t3s-server.yml" up -d --no-deps web_t3s'
alias llat3dw='docker compose -p ubuntu_t3s -f "$HOME/docker-compose-t3s-server.yml" down'
alias llat3dwv='docker compose -p ubuntu_t3s -f "$HOME/docker-compose-t3s-server.yml" down -v'

alias llat3adlsto='sudo -u ubuntu -H bash /home/ubuntu/tool-t3s/scripts/disable-auditlog.sh'
alias llat3adlsta='sudo -u ubuntu -H bash /home/ubuntu/tool-t3s/scripts/enable-auditlog.sh'


alias llat3bktele='sudo -u ubuntu -H bash /home/ubuntu/scripts/t3s/backup-database-to-telegram.sh'
alias llat3bkclfl='sudo -u ubuntu -H bash /home/ubuntu/scripts/t3s/backup-uploads-to-cloudfly.sh'

alias llt3ste='COMPOSE_FILE="${COMPOSE_FILE:-$HOME/docker-compose-t3s-server.yml}" DB_SERVICE="${DB_SERVICE:-db_t3s}" DB_CONTAINER="${DB_CONTAINER:-xanhlamdong_db_t3s}" DB_NAME="${DB_NAME:-xanhlamdong_db_t3s}" DB_USER="${DB_USER:-xanhlamdong_user_t3s}" LOCAL_FILE="${LOCAL_FILE:-$HOME/datas/structure-t3.sql}" ~/tool-daihung/scripts/daihung/export-structure-daihung-server.sh'
alias llt3dte='COMPOSE_FILE="${COMPOSE_FILE:-$HOME/docker-compose-t3s-server.yml}" DB_SERVICE="${DB_SERVICE:-db_t3s}" DB_CONTAINER="${DB_CONTAINER:-xanhlamdong_db_t3s}" DB_NAME="${DB_NAME:-xanhlamdong_db_t3s}" DB_USER="${DB_USER:-xanhlamdong_user_t3s}" LOCAL_FILE="${LOCAL_FILE:-$HOME/datas/data-t3.sql}" ~/tool-daihung/scripts/daihung/export-datas-daihung-server.sh'








#
#
# tool-diem-sac
#
alias lladsp='docker pull cskhhtms/diem_sac_web:deploy_latest'
alias lladsd='docker compose -p user_one_htms -f "$HOME/docker-compose.yml" up -d --no-deps web'
alias lladssta='docker compose -p user_one_htms -f "$HOME/docker-compose.yml" up -d --no-deps web'
alias lladsdw='docker compose -p user_one_htms -f "$HOME/docker-compose.yml" down'
alias lladsdwv='docker compose -p user_one_htms -f "$HOME/docker-compose.yml" down -v'

alias lladsadlsto='sudo -u ubuntu -H bash /home/ubuntu/tool-diem-sac/scripts/disable-auditlog.sh'
alias lladsadlsta='sudo -u ubuntu -H bash /home/ubuntu/tool-diem-sac/scripts/enable-auditlog.sh'

alias lladsbktele='sudo -u ubuntu -H bash /home/ubuntu/scripts/diem-sac/backup-database-to-telegram.sh'
alias lladsbkclfl='sudo -u ubuntu -H bash /home/ubuntu/scripts/s3-to-cloudfly-backup.sh --run'





#
#
# tool-tpdn:
#
alias llatpp='docker pull cskhhtms/tpdn_web:deploy_latest'
alias llatpd='docker compose --env-file "$HOME/docker/tpdn.htms.vn/.env.server" -p tpdn_web_server -f "$HOME/docker/tpdn.htms.vn/docker-compose-server.yml" up -d --no-deps tpdn_web'
alias llatpsta='docker compose --env-file "$HOME/docker/tpdn.htms.vn/.env.server" -p tpdn_web_server -f "$HOME/docker/tpdn.htms.vn/docker-compose-server.yml" up -d --no-deps tpdn_web'
alias llatpdw='docker compose --env-file "$HOME/docker/tpdn.htms.vn/.env.server" -p tpdn_web_server -f "$HOME/docker/tpdn.htms.vn/docker-compose-server.yml" down'
alias llatpdwv='docker compose --env-file "$HOME/docker/tpdn.htms.vn/.env.server" -p tpdn_web_server -f "$HOME/docker/tpdn.htms.vn/docker-compose-server.yml" down -v'

alias llatpadlsto='sudo -u ubuntu -H bash /home/ubuntu/tool-tpdn/scripts/disable-auditlog.sh'
alias llatpadlsta='sudo -u ubuntu -H bash /home/ubuntu/tool-tpdn/scripts/enable-auditlog.sh'

alias llatpbktele='sudo -u ubuntu -H bash /home/ubuntu/scripts/tpdn.htms.vn/backup-database-to-telegram.sh'
alias llatpbkclfl='sudo -u ubuntu -H bash /home/ubuntu/scripts/tpdn.htms.vn/backup-uploads-to-cloudfly.sh --run'



#
#
#
EOF

echo "✅ Đã ghi đè alias vào $ALIASES_FILE"

# 2. Đảm bảo .bashrc có load .bash_aliases
if ! grep -qF 'source ~/.bash_aliases' "$BASHRC" && ! grep -qF '. ~/.bash_aliases' "$BASHRC"; then
  {
    echo ""
    echo "# Load custom aliases"
    echo "if [ -f ~/.bash_aliases ]; then"
    echo "  source ~/.bash_aliases"
    echo "fi"
  } >> "$BASHRC"
  echo "✅ Đã thêm source ~/.bash_aliases vào .bashrc"
fi

# 3. Reload alias ngay trong shell hiện tại
source "$ALIASES_FILE"

echo "🚀 DONE! Dùng được ngay:"
echo "   lla | llar | llal | llac | llas | llla | lllb | llls | lllu | llul | llgl | lldl"
