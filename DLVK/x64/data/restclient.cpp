!include("restclient.h") //Include the defined vars
DevServer("https://plsdev.dyinglightgame.com")
ProdServer("https://pls.dyinglightgame.com")
EnablePLS(1)
EnableMOTDs(1)
EnablePatches(0) //Disabled to allow passthrough of targeted scripts
EnableEvents(1)
EnableRewards(1)
EnableRejectionChecksums(0)
ReleaseLevel(100)
DownloadBufferSize(65536)
EnableTestPatching(0)//Only use if you know how. v v v 
TestGetPatch(0)
TestGetEvent(0)
TestUseLocalFilesInsteadOfServer(1) //Prevents overriding any client changes.
