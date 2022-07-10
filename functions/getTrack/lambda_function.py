import spotipy
from spotipy.oauth2 import SpotifyClientCredentials

client_id='68afa0d8ff0b4751b1e7ce547502cba7'
client_secret='a02fa9b3f79d4325bc275c4304b16cf4'

sp= spotipy.Spotify (auth_manager=SpotifyClientCredentials(client_id=client_id, client_secret=client_secret))


def getTrack(trackName):
    result = sp.search(q='track:'+trackName, type='track', limit=1 )
    songs = []
    for item in result['tracks']['items']:
        songs.append(
            {
                'id': item['id'], 
                'name': item['name'], 
                'time': item['duration_ms'], 
                'artist': item['artists'][0]['name'], 
                'link': item['external_urls']['spotify'],
                'image': item['album']['images'][0]['url'],
                'preview_url': item['preview_url'] 
            }
        )
    return {"statusCode": 200, "body": songs}

getTrack('hello')

# def lambda_handler(event, context):
#     return getTrack(event['trackName'])
