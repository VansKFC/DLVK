sub main(){
!Device(s,f,f,f,f,s,f,f)
!DefaultPCDevice(i)
!GammaSteps(i)
GammaSteps(0)
Device("&DisplayDevice_Monitor&",0.0,1.0,1.0,1.0,"curves_def.dds",0,0.0)
Device("&DisplayDevice_TV&",0.0,1.0,1.0,1.0,"curves_def.dds",0,0.0)
DefaultPCDevice(1) return 0;}
