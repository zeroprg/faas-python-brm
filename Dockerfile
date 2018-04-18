FROM alpine:3.7
#FROM python:3
RUN apk add --no-cache python3 
RUN python3 -m ensurepip
RUN rm -r /usr/lib/python*/ensurepip
RUN pip3 install --upgrade pip setuptools
RUN if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi
RUN rm -r /root/.cache
RUN apk add --no-cache libstdc++ lapack-dev
RUN apk add --no-cache  g++ gfortran musl-dev  python3-dev
RUN ln -s locale.h /usr/include/xlocale.h
RUN pip3 install numpy
RUN pip3 install argparse
#RUN pip3 install pandas
RUN pip3 install scipy
RUN pip3 install theano
#RUN pip3 install tensorflow #need to build
#RUN pip3 install scikit-learn
#COPY function/requirements.txt . #couldn't find it
#RUN pip3 install -r requirements.txt
RUN pip3 install xlrd

RUN rm /usr/include/xlocale.h
RUN rm -rf /root/.cache
#RUN apk del .build-dependencies

WORKDIR /root/

COPY index.py .
COPY RulesFactory.py .
COPY RuleEvaluator.py .
COPY BRMRulesInColumns.xlsx .
COPY matrixOfParams.xlsx .

# Open FaaS
ADD https://github.com/openfaas/faas/releases/download/0.7.1/fwatchdog-armhf /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

# Populate example here - i.e. "cat", "sha512sum" or "node index.js"
ENV fprocess="python3 index.py"
# Set to true to see request in function logs
ENV write_debug="true"

HEALTHCHECK --interval=5s CMD [ -e /tmp/.lock ] || exit 1
CMD [ "fwatchdog" ]

# Use this line  if you want to use bare Docker image
#CMD [ "python3", "./index.py" ]
