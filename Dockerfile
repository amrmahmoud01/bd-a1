FROM ubuntu

RUN apt-get update && apt-get install -y python3.6 python3-distutils python3-pip python3-apt

RUN pip3 install pandas && pip3 install numpy && pip3 install seaborn && pip3 install matplotlib && pip3 install scikit-learn && pip3 install scipy

RUN mkdir -p /home/doc-bd-a1/

COPY train_titanic.csv /home/doc-bd-a1/

COPY load.py /home/doc-bd-a1/

COPY dpre.py /home/doc-bd-a1/




CMD "/bin/bash"