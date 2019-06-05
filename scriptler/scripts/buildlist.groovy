def build = "/home/jenkins/scriptler/scripts/buildlst.sh".execute()
build.waitFor()
bld = build.in.text.split() as List
