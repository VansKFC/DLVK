import std.stdio;
import std.string;

int main(string[] args) {
  
  write("---------------------------------\n");
  write("Dying Light Vulkan Installer | D\n");
  write("---------------------------------\n");
  write("Install an Official or Custom build?: \n");
  write(" \n");
  write(" \n");
  write("Chose : ");

 auto input = strip(stdin.readln());
 if(input == "Official") {
  write("Install which version?\n");
  write("> Latest\n");
  write("> Dying Light Vulkan | Release 2-38.0\n");
  }
  if(input == "Custom") {
    write("Install what Fork?\n");
    write("VansKFC's Personal Preferences 2.4-38.0\n");
  }
  do{
    strip(stdin.readln());
    write("Function goes here.\n");
  }while(input == "Latest");
 return 0;
}