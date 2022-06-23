import os
import json
import uuid
from boto3 import client as boto3
import base64

rekognition = boto3("rekognition")
s3 = boto3("s3")

# Constants
BUCKET_NAME = os.environ['BUCKET_NAME']

def buildResponse(statusCode, body):

    return {
        'statusCode': statusCode,
        'body': body
    }

def saveImage(image):

    try:
        photo_key = str(uuid.uuid1())
        
        s3_response = s3.put_object(
            Bucket=BUCKET_NAME, Key=photo_key, Body=image
        )
        return (photo_key)

    except Exception as e:
        return ("error")

def lambda_handler(event, context):

    photo_key = saveImage(base64.b64decode(event['content']))

    if photo_key != "error":

        rekognition_res = rekognition.detect_faces(
            Image={'S3Object': {
                'Bucket': BUCKET_NAME, 
                'Name': photo_key
                }
            }, 
            Attributes=["ALL"]
        )

        faceDetails = rekognition_res["FaceDetails"]

        if rekognition_res == []:
            return (buildResponse(500, {"Message": "Rekognition was not able to identify a face"}))
        else:
            return (buildResponse(200, faceDetails[0]["Emotions"][0]))

    else:
        return (buildResponse(400, {"Message": "Bad request"}))
