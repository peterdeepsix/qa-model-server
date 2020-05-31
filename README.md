# qa-model-server

docker run -t --rm -p 8501:8501 --mount type=bind,source="$(pwd)/.models/distilbert-base-cased-distilled-squad/",target="/models/cased/1" -e MODEL_NAME=cased tensorflow/serving