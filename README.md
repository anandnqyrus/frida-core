# Frida

Dynamic instrumentation toolkit for developers, reverse-engineers, and security
researchers. Learn more at [frida.re](https://frida.re/).

# Steps to build the frida binaries
1. Run - sudo apt-get install build-essential git lib32stdc++-9-dev libc6-dev-i386 nodejs npm as a prerequisite ( nodejs version should be >= 18)
2. Inside the git project root folder (/frida) run - ./configure. This will configure the build for the native machine on which we're building.
3. Next, run - make. Which will use ./build as the build directory.
4. Post the success of the above command run - make install to install the frida binaries (might require sudo permissions for this).
5. The binaries will be installed in - /usr/local/bin and /usr/local/lib typically -
   ![image](https://github.com/user-attachments/assets/cacb77a3-2005-4351-8957-f30596f6906c)
6. We need to copy these 2 folders into a folder called frida-binaries to get use these generated frida binaries. The entire git project is not needed. We can transfer the      folder with these binaries to the image. Commands which will accomplish the above -

   1. sudo mkdir frida-binaries ( location is of choice as we need to move this folder to the image according to the Dockerfile)
   
   2. sudo cp -r /usr/local/bin /frida-binaries/
   
   3. sudo cp -r /usr/local/lib /frida-binaries/
     
8. We can bundle the frida-binaries folder with the Dockerfile in the project root with the biometrics war file to build the docker image and push it to ECR.

   Example of a zipped folder with all assets - (https://qonline-my.sharepoint.com/:u:/g/personal/anandn_quinnox_com/EauoaEAFhAtBoGgeOZHxP4gBQA5F-Y3yrrPgyTvspOfXBQ?e=moSPqu
)   

Reference - [frida-build-instructions](https://frida.re/docs/building/)
