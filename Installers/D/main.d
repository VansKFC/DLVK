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
  }
  if(input == "Custom") {
    write("Install what Fork?\n");
  }
 return 0;
}