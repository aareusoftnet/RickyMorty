## RickyMorty:

I have created an application using **The Rick and Morty API** with different screen UIs.

![Splash-Screen][1-splash_screen-link]
![EpisodeTab-Screen][2-episode_tab_screen-link]
![EpisodeTabSearch-Screen][2.1-episode_tab_search_screen-link]
![LoactionTab-Screen][3-location_tab_screen-link]
![CharacterListLoading-Screen][4-character_list_loading_screen-link]
![CharacterList-Screen][4.1-character_list_screen-link]
![CharacterListUIContextMenu-Screen][4.2-character_list_uicontextmenu_screen-link]
![CharacterDetail-Screen][5-character_detail_screen-link]

## Requirements:

- iOS 13.0+
- Xcode 12+
- Swift 5.0+
- Zeplin

## Tools & Library used:

- **[Rick&Morty API Homepage](https://rickandmortyapi.com/)** - To fetch the data and dislay Episosde, Location & Character details.
- **[Alamofire](https://github.com/Alamofire/Alamofire)** - To handle network communication and API calls.
- **[SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)** - To dealing with JSON data in Swift.
- **[Kingfisher](https://github.com/onevcat/Kingfisher)** - To downloading & caching image.
- **[Sketch](https://www.sketch.com/)** - To design application skelaton.
- **[Zeplin](https://app.zeplin.io/login)** - To export application design skelaton.
- **[GitHub](https://github.com/aareusoftnet)** - To manage source code.

## Zeplin:

- **[RickyMorty](https://zpl.io/bJ8KNyx)** - It contains all the screens assets with mark as exportable.

## Assets:

List of assets your can find here, icnluding application icons:
https://github.com/aareusoftnet/RickyMorty/tree/main/Assets

- **[AppIcons](https://github.com/aareusoftnet/RickyMorty/tree/main/Assets/AppIcons)** - It contains application icons.
- **[Sketch](https://github.com/aareusoftnet/RickyMorty/tree/main/Assets/Sketch)** - It contains **[RickyMorty.sketch](https://github.com/aareusoftnet/RickyMorty/blob/main/Assets/Sketch/RickyMorty.sketch)** file to add/update designs.

## Documents:

List of documents your can find here:
https://github.com/aareusoftnet/RickyMorty/tree/main/Documents

- **[iOS Code Challenge [3].pdf](https://github.com/aareusoftnet/RickyMorty/blob/main/Documents/iOS%20Code%20Challenge%20%5B3%5D.pdf)** - It contains application icons.
- **[Rick&MortyAIPs.postman_collection.json](https://github.com/aareusoftnet/RickyMorty/blob/main/Documents/Rick&MortyAIPs.postman_collection.json)** - It contains postman collections to check list of used APIs in application.

## Profile&Certificates:

List of profile and certificates you can find here:
https://github.com/aareusoftnet/RickyMorty/tree/main/Profile%26Certificates

- **Apple-Development.p12** file use as Development certificate and has no any password.
- **RickyMorty_AppleDevelopment_Profile.mobileprovision** file use as Development profile to execute application in your device.

## Resources:

List of resources you can find here:
https://github.com/aareusoftnet/RickyMorty/tree/main/Resources

- **[Fonts](https://github.com/aareusoftnet/RickyMorty/tree/main/Resources/Fonts)** - It contains list of Fonts file which are used in application.

## SourceCode:

It's a project root directory you can open **RickyMorty/RickyMorty.xcodeproj** file in xCode to debug and make an archive.
https://github.com/aareusoftnet/RickyMorty/tree/main/SourceCode

### Terms use in coding

- `TVC` - It's a postfix for any TVC(Table View Cell) file.
- `CVC` - It's a postfix for any CVC(Collection View Cell) file.
- `VC` - It's a postfix for any VC(UIViewController) file.
- `VM` - It's a postfix for any VM(ViewModel) file.
- `XIBs` - It's a directory which contains list of NIBs, also known as Views.
- `APIs` - It's a directory which contains list of RickyMortyAPIs call and APIs core classes.

### Features Included

1. **Splash Screen**

   - Splash screen implemted with Brand logo.

2. **EpisodeTab Screen**

   - Contains a table view that displays list of episodes informations.
   - Contains SearchBar which is used to search the episode by it's name.
   - Contains Loading indicator while searching episode.
   - The default items in the table view is default episodes with default pagination.
   - Ability to navigate to character list screen.

3. **LocationTab Screen**

   - Contains a table view that displays list of locations informations.
   - Contains SearchBar which is used to search the location by it's name.
   - Contains Loading indicator while searching location.
   - The default items in the table view is default locations with default pagination.
   - Ability to navigate to character list screen.

4. **CharacterList Screen**

   - Contains a table view that displays list of characters informations.
   - Display the characters informations based on Selected Episode or Location.
   - Ability to filter the list of characters by providing list of filter options.
   - UIContextMenu to preview the character detail screen.

5. **CharacterDetails Screen**
   - Display all the possible information provided in Character object.

## Contact:

[![linkedINContact][linkedincontactme-badge]][linkedin-link]
[![UpworkContact][upworkcontactme-badge]][upwork-link]

## Acknowledgements:

- [Rick&Morty API Homepage](https://rickandmortyapi.com/)
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [Sketch](https://www.sketch.com/)
- [Zeplin](https://app.zeplin.io/login)
- [GitHub](https://github.com/aareusoftnet)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[linkedincontactme-badge]: https://img.shields.io/badge/linkedIN-CONTACT%20ME-blue?style=for-the-badge
[linkedin-link]: https://www.linkedin.com/in/aareusoftnet
[upworkcontactme-badge]: https://img.shields.io/static/v1?style=for-the-badge&label=UPWORK&message=CONTACT%20ME&color=OOOOOO
[upwork-link]: https://www.upwork.com/freelancers/~012d5b6e889c57a2a1
[1-splash_screen-link]: https://github.com/aareusoftnet/RickyMorty/blob/main/Assets/Screens/1-Splash_Screen.PNG
[2-episode_tab_screen-link]: https://github.com/aareusoftnet/RickyMorty/blob/main/Assets/Screens/2-Episode_Tab_Screen.PNG
[2.1-episode_tab_search_screen-link]: https://github.com/aareusoftnet/RickyMorty/blob/main/Assets/Screens/2.1-Episode_Tab_Search_Screen.PNG
[3-location_tab_screen-link]: https://github.com/aareusoftnet/RickyMorty/blob/main/Assets/Screens/3-Location_Tab_Screen.PNG
[4-character_list_loading_screen-link]: https://github.com/aareusoftnet/RickyMorty/blob/main/Assets/Screens/4-Character_List_Loading_Screen.PNG
[4.1-character_list_screen-link]: https://github.com/aareusoftnet/RickyMorty/blob/main/Assets/Screens/4.1-Character_List_Screen.PNG
[4.2-character_list_uicontextmenu_screen-link]: https://github.com/aareusoftnet/RickyMorty/blob/main/Assets/Screens/4.2-Character_List_UIContextMenu_Screen.PNG
[5-character_detail_screen-link]: https://github.com/aareusoftnet/RickyMorty/blob/main/Assets/Screens/5-Character_Detail_Screen.PNG
