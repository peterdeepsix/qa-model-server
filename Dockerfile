FROM tensorflow/serving



WORKDIR /usr/src/app

ENV PORT 8080
ENV HOST 0.0.0.0

RUN npx question-answering download

COPY package*.json ./

RUN npm install --only=production

# Copy the local code to the container
COPY . .


# Start the service
CMD npm start