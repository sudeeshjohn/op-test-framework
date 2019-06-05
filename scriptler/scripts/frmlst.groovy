def proc = "/home/jenkins/scriptler/scripts/frmlst.sh".execute()
proc.waitFor()
lst =proc.in.text.split() as List
