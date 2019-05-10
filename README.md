# Emergency Blips

Looking for a script to add blips on the map for only certain players -- like police, or  EMS for example? Look no further!

<details>
<summary>Screenshot</summary>
<br>

![weaponsonback|690x388](https://i.imgur.com/IanbmUu.png)

(An example of a blip that shows for only certain specified players)

</details>

## Features

- Works for any framework (as well as no framework, of course)
- Easy API

## Installation

- Download from here.
- Put the ``EmergencyBlips`` folder into your server's ``resources`` folder.
- Add ``start EmergencyBlips`` to your server's ``server.cfg`` file.
- Enjoy!

## Usage

- Use ``TriggerEvent("eblips:add", {name = "Jane Doe", src = 123, color = 1})`` when you want to make a person show up on the map for other people who have also been made to show on the map.

- Use ``TriggerEvent("eblips:remove", serverID)`` when you want to stop a person who is showing up on the map from showing on the map.

- For ``eblips:add``: ``name`` is the text that shows on the map when a blip is selected, ``src`` should be the player's server ID, and ``color`` is the blip color.

- Both events are server events.

- See https://wiki.gtanet.work/index.php?title=Blips for blip color codes (at bottom).


*P.S. this is a developer resource and does nothing by itself, you must use the above two events for blips to show. Oh, and feel free to offer feedback, suggestions, or even contribute via the repository!*
