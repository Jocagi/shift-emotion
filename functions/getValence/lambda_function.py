import spotipy
from spotipy.oauth2 import SpotifyClientCredentials

client_id='68afa0d8ff0b4751b1e7ce547502cba7'
client_secret='a02fa9b3f79d4325bc275c4304b16cf4'

sp= spotipy.Spotify (auth_manager=SpotifyClientCredentials(client_id=client_id, client_secret=client_secret))


def getValence(trackId):
    result= sp.audio_analysis(trackId)
    return {"statusCode": 200, "body": result}

def lambda_handler(event, context):
    return getValence()
