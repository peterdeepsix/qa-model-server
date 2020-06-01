FROM tensorflow/serving

WORKDIR /usr/src/app

ENV PORT 8501
ENV HOST 0.0.0.0

# Copy the local code to the container
COPY .models/distilbert-cased/ /models/cased/1