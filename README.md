# JioSaavn to Spotify


<img src="https://github.com/sarthakkotia/JioSaavnToSpotify/assets/37319907/f6df2791-9097-4f61-a715-8b69ca2ab2c8" width=50% height=6.25%>



A Flutter project which aims to simplify the process of transferring your favorite JioSaavn songs from JioSaavn playlists to Spotify so that you can enjoy them on your Spotify playlists with ease.

**Features**
* Easy-to-use Material You themed user interface for an enjoyable user experience.
* Simple and straightforward song selection and playlist addition process.
* Secure authentication with Spotify to access user playlists and add songs.

**How it Works**
* User have a predetermined playlists to choose from Jiosaavn app due to unavailablity of Jiosaavn Public API
* Retrieve JioSaavn Song: The app sends the search query to the JioSaavn API, which returns the playlists with songs data
* Spotify Authentication: Users can then authenticate themselves using their spotify account using Spotify Api
* Retreive current Spotify Playlists: Using the Spotify Api user may be able to access their playlist to add songs or alternatively they can also create a new playlist from the app itself.
* For each song in the jiosaavn playlist user have the ability to decide wheather to add the corresponding song whic was searched in spotify and users can change the search query as well! or they could skip that particular song
* If the song is already in the User's selected spotify playlist it would automatically be skipped hence avoiding clashes
<img src="https://github.com/sarthakkotia/JioSaavnToSpotify/assets/37319907/fa0dc471-7a65-4383-b4ff-81f6e6c07652" width=50% height=6.25%>
<br>
**See the app in action**
  ![video](https://github.com/sarthakkotia/JioSaavnToSpotify/assets/37319907/4f577779-0794-400c-a5b6-a47698b1b113)

**See the code in action**
Prerequisites
Make Sure you have flutter SDK installed with the IDE of your choice
*Run the app with Android Studio or VS Code. Or the command line:
flutter pub get
flutter run











