FROM ubuntu:22.04

ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    python3=3.10.6-1~22.04 \
    python3-minimal=3.10.6-1~22.04 \
    libpython3-stdlib=3.10.6-1~22.04 \
    python3-pip=22.0.2+dfsg-1ubuntu0.4 \
    && \
    apt-get install -y \
    adb=1:10.0.0+r36-9 \
    libssl-dev=3.0.2-0ubuntu1.17 \
    build-essential=12.9ubuntu3 \
    curl=7.81.0-1ubuntu1.17 \
    default-jdk=2:1.11-72build2 \
    unzip=6.0-26ubuntu3.2 \
    wget=1.21.2-2ubuntu1.1 \
    android-sdk=28.0.2+6 \
    android-sdk-platform-tools=28.0.2+6 \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs


RUN wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool \
    && wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.9.0.jar -O apktool.jar \
    && chmod +x apktool apktool.jar \
    && mv apktool /usr/local/bin/ \
    && mv apktool.jar /usr/local/bin/

# Copy the custom Frida binaries and biometrics war
COPY frida-binaries /opt/frida
COPY biometrics-0.0.1-SNAPSHOT.war /app/biometrics-0.0.1-SNAPSHOT.war

# Convert line endings for all files in /opt/frida/bin in case of windows system
# RUN find /opt/frida/bin -type f -exec dos2unix {} \;

# Set up environment variables
ENV PATH="/opt/frida/bin:${PATH}"
ENV PYTHONPATH="/opt/frida/lib/python3/dist-packages:${PYTHONPATH}"

# Install any additional Python dependencies
RUN pip install colorama prompt-toolkit pygments typing-extensions requests semver==2.13.0 litecli tabulate

RUN pip3 install click delegator.py flask

RUN pip3 install --no-deps objection

# Set working directory
WORKDIR /app

RUN apt-get update && apt-get install -y openjdk-8-jre-headless && rm -rf /var/lib/apt/lists/*

EXPOSE 7004

RUN chmod +x /opt/frida/bin/*

# ENTRYPOINT ["sh", "/app/start.sh"]
ENTRYPOINT ["java", "-jar","/app/biometrics-0.0.1-SNAPSHOT.war"]
