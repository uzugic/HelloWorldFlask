# We are basing our builder image on openshift base-centos7 image
FROM registry.redhat.io/ubi7

# Inform users who's the maintainer of this builder image
MAINTAINER micacar <mica@car>

# Inform about software versions being used inside the builder
#ENV LIGHTTPD_VERSION=1.4.35

# Set labels used in OpenShift to describe the builder images
#LABEL io.k8s.description="Platform for serving static HTML files" \
#	  io.k8s.display-name="Lighttpd 1.4.35" \
#      io.openshift.expose-services="8080:http" \
#      io.openshift.tags="builder,html,lighttpd"

# Install the required software, namely Lighttpd and
#RUN yum install -y python-setuptools
RUN easy_install pip 
RUN pip install flask flask-wtf flask-babel markdown flup
RUN yum install -y git
    # clean yum cache files, as they are not needed and will only make the image bigger in the end
RUN yum clean all -y

RUN git init
RUN git remote add origin https://github.com/uzugic/HelloWorldFlask.git
RUN git pull origin master
	
#RUN cd HelloWorldFlask

# Defines the location of the S2I
# Although this is defined in openshift/base-centos7 image it's repeated here
# to make it clear why the following COPY operation is happening
#LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i
# Copy the S2I scripts from ./.s2i/bin/ to /usr/local/s2i when making the builder image
#COPY ./.s2i/bin/ /usr/local/s2i

# Copy the lighttpd configuration file
#COPY ./etc/ /opt/app-root/etc

# Drop the root user and make the content of /opt/app-root owned by user 1001
#RUN chown -R 1001:1001 /opt/app-root

# Set the default user for the image, the user itself was created in the base image
#USER 1001

# Specify the ports the final image will expose
EXPOSE 8080
#RUN cd HelloWorldFlask
# Set the default CMD to print the usage of the image, if somebody does docker run
CMD ["python", "app.py"]
