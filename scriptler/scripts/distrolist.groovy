def build = "/home/jenkins/scriptler/scripts/distro.sh".execute()
build.waitFor()
bld = build.in.text.split() as List
