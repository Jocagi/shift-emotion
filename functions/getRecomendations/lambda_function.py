import spotipy
from spotipy.oauth2 import SpotifyClientCredentials

client_id='68afa0d8ff0b4751b1e7ce547502cba7'
client_secret='a02fa9b3f79d4325bc275c4304b16cf4'

sp= spotipy.Spotify (auth_manager=SpotifyClientCredentials(client_id=client_id, client_secret=client_secret))


genres= ["pop"]

artistDictionary = {
    "happy": [ "4q3ewBCX7sLwd24euuV69X", "1vyhD5VmyZ7KMfW5gqLgo5" ],
    "sad": [ "4q3ewBCX7sLwd24euuV69X", "4dpARuHxo51G3z768sgnrY" ],
    "angry": [ "7oPftvlwr6VrsViSDV7fJY" , "5C4PDR4LnhZTbVnKWXuDKD" ],
    "confused": [ "4q3ewBCX7sLwd24euuV69X" , "6KImCVD70vtIoJWnq6nGn3" ],
    "disgusted": [ "4q3ewBCX7sLwd24euuV69X" , "5C4PDR4LnhZTbVnKWXuDKD" ],
    "surprised": [ "4q3ewBCX7sLwd24euuV69X" , "5C4PDR4LnhZTbVnKWXuDKD" ],
    "calm": [ "4q3ewBCX7sLwd24euuV69X" , "5r4OqYJL7JrtZlffx7FJlb" ],
    "unknown": [ "4q3ewBCX7sLwd24euuV69X" , "6KImCVD70vtIoJWnq6nGn3" ],
    "fear": [ "0k17h0D3J5VfsdmQ1iZtE9", "3RNrq3jvMZxD9ZyoOZbQOD" ],
}

tracksDictionary = {
    "happy": ["0IqCoZ168iRc9LqfrYgpZy", "7cYNQkJoyHVhP8Drb2n6d5" ],
    "sad": ["2MnLkFqY9Rpg9s3Zv6ZJdK", "35wvL50xvKpCHEJPxLOLPI" ],
    "angry": ["45hOioMDJktr86iKDHC8gr", "4fouWK6XVHhzl78KzQ1UjL" ],
    "confused": ["0IqCoZ168iRc9LqfrYgpZy", "6aKyJeHH2EvHUaeJikCc9E" ],
    "disgusted": ["4iL2i3kck6tRcbSGuXJOe7", "45hOioMDJktr86iKDHC8gr" ],
    "surprised": ["5NhcE6cuJjVYyVEKp97zOt" ],
    "calm": ["0IqCoZ168iRc9LqfrYgpZy", "4fouWK6XVHhzl78KzQ1UjL" ],
    "unknown": ["0IqCoZ168iRc9LqfrYgpZy", "7cYNQkJoyHVhP8Drb2n6d5" ],
    "fear": [ "2B7Ip5UezkdaW31SWujvI7", "6wBoZc8SwGed6EPApAXuWo" ],
}

def getRecomendations(emotion):
    result = sp.recommendations(seed_artists= artistDictionary[emotion], seed_tracks=tracksDictionary[emotion], seed_genres=genres )
    songs = []
    for item in result['tracks']:
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

def lambda_handler(event, context):
    return getRecomendations(event['emotion'])
