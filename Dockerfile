# We are basing our builder image on rhel7 ubi image
FROM docker-registry.default.svc:5000/openshift/ubi

# Inform users who's the maintainer of this builder image
MAINTAINER micacar <mica@car>

# Install the required software
#RUN yum install -y python-setuptools
#RUN yum -y install curl
RUN easy_install pip 
RUN pip install flask 
#flask-wtf flask-babel markdown flup
#RUN yum install -y git
    # clean yum cache files, as they are not needed and will only make the image bigger in the end
RUN yum clean all -y

RUN curl https://raw.githubusercontent.com/uzugic/HelloWorldFlask/master/app.py -o app.py

#RUN git init
#RUN git remote add origin https://github.com/uzugic/HelloWorldFlask.git
#RUN git pull origin master
	
#RUN cd HelloWorldFlask

# Specify the ports the final image will expose
EXPOSE 8080

# Set the default CMD to print the usage of the image, if somebody does docker run
CMD ["python", "app.py"]
