# qa-model-server local

npx question-answering download distilbert-base-cased-distilled-squad

docker run -t --rm -p 8501:8501 --mount type=bind,source="$(pwd)/.models/distilbert-base-cased-distilled-squad/",target="/models/cased/1" -e MODEL_NAME=cased tensorflow/serving

# gcloud container repo config

gcloud iam service-accounts create container-registry-sa --display-name="container-registry-sa"

gcloud projects add-iam-policy-binding entroprise-production --member=serviceAccount:container-registry-sa@entroprise-production.iam.gserviceaccount.com --role=roles/storage.admin

gcloud iam service-accounts keys create docker-key.json --iam-account=container-registry-sa@entroprise-production.iam.gserviceaccount.com

gcloud auth activate-service-account container-registry-sa@entroprise-production.iam.gserviceaccount.com --key-file=docker-key.json



# copy model into container
docker run -d --name serving_base tensorflow/serving

docker cp .models/distilbert-base-cased-distilled-squad serving_base:/models/cased
docker cp .models/distilbert-base-cased-distilled-squad serving_base:/models/cased/1

docker commit --change "ENV MODEL_NAME cased " serving_base qa-serving

docker kill serving_base

docker rm serving_base

docker run -p 8500:8500 -p 8501:8501 -t qa-serving

docker tag qa-serving gcr.io/entroprise-production/qa-serving

docker push gcr.io/entroprise-production/qa-serving


