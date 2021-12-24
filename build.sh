#!/bin/bash
echo "your name is $(whoami) ~"

#check os versions
os_install=
os_commond(){
    os_type=$(lsb_release -si)
    if [ os_type="Ubuntu" ];then
    os_install="sudo apt-get"
    
    elif [ os_type="Centos" ];then
    os_install="yum"
    fi
}
#install and touch dir
cs_dir=
check_install(){
    own_dir="/home/$(whoami)"
    if [ ! -d $own_dir ];then
    mkdir $own_dir
    fi
    # echo "[+] update ...."
    if [ ! $(command -v java) ]; then
    $os_install update && $os_install install openjdk-8-jdk -y && $os_install install coreutils -y
    fi

    cs_dir="${own_dir}/cobaltstrike4.4"
    if [ ! -d $cs_dir ];then
        mkdir $cs_dir
    fi
}

#print_color
function print_info () {
    echo -e "\x1B[01;34m[*]\x1B[0m $1"
}


#check jar
check_csfile(){
    if [ ! -f "cobaltstrike.jar" ];then
    echo "plz upload jar!"
    exit
    else
        cp cobaltstrike.jar ${cs_dir}/cobaltstrike.jar
    fi

}
#rand_cs_pass_and_port
rand_cs_pass=
rand_pass(){
    pass=$(echo -n "$RANDOM""$RANDOM""$RANDOM""$RANDOM""$RANDOM"|md5sum |cut -c 1-32)
    rand_cs_pass=$(echo -n ${pass}|md5sum |cut -c 1-32)
}
rand_cs_port=
rand_port(){
    port_list=($(seq 40000 65535))
    rand_cs_port=${port_list[`expr $RANDOM % 25535`]}
}

#write profile
write_profile(){
    if [ ! -f "${cs_dir}/default.profile" ];then
    profile_base64="c2V0IHNsZWVwdGltZSAiNTAwMCI7CnNldCBqaXR0ZXIgICAgIjAiOwpzZXQgbWF4ZG5zICAgICIy\
NTUiOwpzZXQgdXNlcmFnZW50ICJNb3ppbGxhLzUuMCAoTWFjaW50b3NoOyBJbnRlbCBNYWMgT1Mg\
WCAxMC4xNTsgcnY6ODAuMCkgR2Vja28vMjAxMDAxMDEgRmlyZWZveC84MC4wIjsKCmh0dHAtZ2V0\
IHsKCiAgICBzZXQgdXJpICIvYXBpL3giOwoKICAgIGNsaWVudCB7CiAgICAgICAgaGVhZGVyICJB\
Y2NlcHQiICIqLyoiOwogICAgICAgIG1ldGFkYXRhIHsKICAgICAgICAgICAgYmFzZTY0OwogICAg\
ICAgICAgICBwcmVwZW5kICJTRVNTSU9OSUQ9IjsKICAgICAgICAgICAgaGVhZGVyICJDb29raWUi\
OwogICAgICAgIH0KICAgIH0KCiAgICBzZXJ2ZXIgewogICAgICAgIGhlYWRlciAiQ29udGVudC1U\
eXBlIiAiYXBwbGljYXRpb24vb2NzcC1yZXNwb25zZSI7CiAgICAgICAgaGVhZGVyICJjb250ZW50\
LXRyYW5zZmVyLWVuY29kaW5nIiAiYmluYXJ5IjsKICAgICAgICBoZWFkZXIgIlNlcnZlciIgIm5n\
aW54IjsKICAgICAgICBvdXRwdXQgewogICAgICAgICAgICBiYXNlNjQ7CiAgICAgICAgICAgIHBy\
aW50OwogICAgICAgIH0KICAgIH0KfQpodHRwLXN0YWdlciB7ICAKICAgIHNldCB1cmlfeDg2ICIv\
dnVlLm1pbi5qcyI7CiAgICBzZXQgdXJpX3g2NCAiL2Jvb3RzdHJhcC0yLm1pbi5qcyI7Cn0KaHR0\
cC1wb3N0IHsKICAgIHNldCB1cmkgIi9hcGkveSI7CiAgICBjbGllbnQgewogICAgICAgIGhlYWRl\
ciAiQWNjZXB0IiAiKi8qIjsKICAgICAgICBpZCB7CiAgICAgICAgICAgIGJhc2U2NDsKICAgICAg\
ICAgICAgcHJlcGVuZCAiSlNFU1NJT049IjsKICAgICAgICAgICAgaGVhZGVyICJDb29raWUiOwog\
ICAgICAgIH0KICAgICAgICBvdXRwdXQgewogICAgICAgICAgICBiYXNlNjQ7CiAgICAgICAgICAg\
IHByaW50OwogICAgICAgIH0KICAgIH0KCiAgICBzZXJ2ZXIgewogICAgICAgIGhlYWRlciAiQ29u\
dGVudC1UeXBlIiAiYXBwbGljYXRpb24vb2NzcC1yZXNwb25zZSI7CiAgICAgICAgaGVhZGVyICJj\
b250ZW50LXRyYW5zZmVyLWVuY29kaW5nIiAiYmluYXJ5IjsKICAgICAgICBoZWFkZXIgIkNvbm5l\
Y3Rpb24iICJrZWVwLWFsaXZlIjsKICAgICAgICBvdXRwdXQgewogICAgICAgICAgICBiYXNlNjQ7\
CiAgICAgICAgICAgIHByaW50OwogICAgICAgIH0KICAgIH0KfQpodHRwLWNvbmZpZyB7CiAgICAg\
ICAgc2V0IGhlYWRlcnMgIlNlcnZlciwgQ29udGVudC1UeXBlLCBDYWNoZS1Db250cm9sLCBDb25u\
ZWN0aW9uLCBYLVBvd2VyZWQtQnkiOwogICAgICAgIGhlYWRlciAiU2VydmVyIiAiTmdpbngiOwog\
ICAgICAgIGhlYWRlciAiQ29udGVudC1UeXBlIiAidGV4dC9odG1sO2NoYXJzZXQ9VVRGLTgiOwog\
ICAgICAgIGhlYWRlciAiQ2FjaGUtQ29udHJvbCIgIm1heC1hZ2U9MSI7CiAgICAgICAgaGVhZGVy\
ICJDb25uZWN0aW9uIiAia2VlcC1hbGl2ZSI7CiAgICAgICAgc2V0IHRydXN0X3hfZm9yd2FyZGVk\
X2ZvciAidHJ1ZSI7Cn0="
    touch ${cs_dir}/default.profile
    echo -n ${profile_base64}|base64 -d > ${cs_dir}/default.profile
    fi
}

#nohup backend
nohup_back(){
    proc="java"
    proc_list=`ps -ef|grep -w ${proc}|grep -v grep|wc -l`
    if [ $proc_list -le 0 ];then
        if [ -e ${cs_dir}/cobaltstrike.store ]; then
	    print_info "Will use existing X509 certificate and keystore (for SSL)"
        else
	    print_info "Generating X509 certificate and keystore (for SSL)"
	    keytool -keystore ${cs_dir}/cobaltstrike.store -storepass Microsoft -keypass Microsoft -genkey -keyalg RSA -alias cobaltstrike -dname "CN=*.microsoft.com, OU=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=WA, C=US"
        fi
    nohup java -XX:ParallelGCThreads=4 -Dcobaltstrike.server_port=${port} -Dcobaltstrike.server_bindto=0.0.0.0 -Djavax.net.ssl.keyStore=${cs_dir}/cobaltstrike.store -Djavax.net.ssl.keyStorePassword=Microsoft -server -XX:+AggressiveHeap -XX:+UseParallelGC -classpath ${cs_dir}/cobaltstrike.jar -javaagent:CSAgent.jar=5e98194a01c6b48fa582a6a9fcbb92d6 -Duser.language=en server.TeamServer ${ip} ${pass} ${cs_dir}/default.profile &
    print_info "your cs ip   is ${ip}"
    print_info "your cs port is ${port}"
    print_info "your cs pass is ${pass}"
    fi
}

#main
main(){
    read -p "plz input ip: " ip
    if [ ! -n $ip ];then
    exit
    fi
    os_commond #os_install
    check_install
    check_csfile
    rand_pass #rand_cs_pass
    rand_port #rand_cs_port
    port=$rand_cs_port
    pass=$rand_cs_pass
    if [ ! -f "${cs_dir}/default.profile" ];then
    write_profile
    fi
    nohup_back

}
main