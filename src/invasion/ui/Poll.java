package invasion.ui;

import invasion.dataobjects.Alt;
import invasion.dataobjects.Item;
import invasion.dataobjects.Location;
import invasion.dataobjects.Message;
import invasion.pets.BroodManager;
import invasion.util.InvasionConnection;
import invasion.util.Whatzit;

import java.io.Writer;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 Sample output of Poll data:
 <code>
 {
    "occs": [
        {
            "id": 1,
            "hp": 1,
            "level": 19,
            "name": "Uncle Purvy"
        }
    ],
    "msgs": [
        {
            "text": "You search and find nothing.",
            "reps": 4,
            "read": true,
            "date": "1 hr ago",
            "type": 0
        },
        {
            "text": "You search and find a Energy pistol.",
            "reps": 1,
            "read": true,
            "date": "1 hr ago",
            "type": 0
        },
        {
            "text": "You search and find nothing.",
            "reps": 1,
            "read": true,
            "date": "1 hr ago",
            "type": 0
        },
        {
            "text": "You search and find a Peach Schnapps.",
            "reps": 1,
            "read": true,
            "date": "1 hr ago",
            "type": 0
        },
        {
            "text": "You search and find nothing.",
            "reps": 1,
            "read": true,
            "date": "1 hr ago",
            "type": 0
        },
        {
            "text": "You search and find a Energy pack.",
            "reps": 1,
            "read": true,
            "date": "1 hr ago",
            "type": 0
        },
        {
            "text": "This is a test of the emergency broadcast system.  This is only a test.",
            "reps": 1,
            "read": true,
            "date": "38 min ago",
            "type": 3
        }
    ],
    "location": {
        "chalk": "Some message here.",
        "level": "1",
        "allowrecharage": "f",
        "locid": "1002450",
        "station": "Crescent",
        "description": "You are in a corridor.  The walls are a sparse white with colored lines forming trails to certain destinations.  There was a hole here.  Its gone now.",
        "name": "null",
        "type": "Corridor",
        "y": 33,
        "x": 14
    },
    "stats": {
        "hp": 20,
        "level": 8,
        "cp": 255,
        "altid": 3,
        "ap": -302,
        "daysalive": 2,
        "xp": 1457,
        "ticksalive": 222,
        "ip": 0
    },
    "pets": [
        {
            "id": "1566",
            "hp": 0,
            "name": "Gremlin 2323"
        },
        {
            "id": "1280",
            "hp": 0,
            "name": "Dalek1280"
        }
    ],
    "ground": [
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Energy pack(empty)",
            "typeid": 49,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 47614,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Flechette cartridge",
            "typeid": 31,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 34814,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Gas cartridge",
            "typeid": 50,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 9214,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Spiced Rum",
            "typeid": 51,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 2814,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Spiced Rum",
            "typeid": 51,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 15614,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Vodka",
            "typeid": 37,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 28414,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Vodka",
            "typeid": 37,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 41214,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Energy rifle",
            "typeid": 27,
            "capacity": 3,
            "equipped": false,
            "damagetype": "e",
            "itemid": 22014,
            "type": "weapon",
            "wt": 10
        }
    ],
    "inv": [
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53998,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53827,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53959,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 54008,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 54000,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Battered",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53958,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Battered",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 54001,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Operational",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53970,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Average",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53829,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Average",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53986,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Average",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53961,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Average",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53980,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Average",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53955,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "To spec",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53950,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "To spec",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53910,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "To spec",
            "hidden": false,
            "name": "Energy pack",
            "typeid": 28,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53918,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Energy pack(empty)",
            "typeid": 49,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53730,
            "type": "ammo",
            "wt": 1
        },
        {
            "ammoleft": 7,
            "condition": "Broken",
            "hidden": false,
            "name": "Personal shield",
            "typeid": 35,
            "capacity": 50,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53977,
            "type": "armor",
            "wt": 3
        },
        {
            "ammoleft": 12,
            "condition": "Broken",
            "hidden": false,
            "name": "Personal shield",
            "typeid": 35,
            "capacity": 50,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53991,
            "type": "armor",
            "wt": 3
        },
        {
            "ammoleft": 23,
            "condition": "Broken",
            "hidden": false,
            "name": "Personal shield",
            "typeid": 35,
            "capacity": 50,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53992,
            "type": "armor",
            "wt": 3
        },
        {
            "ammoleft": 34,
            "condition": "Broken",
            "hidden": false,
            "name": "Personal shield",
            "typeid": 35,
            "capacity": 50,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53978,
            "type": "armor",
            "wt": 3
        },
        {
            "ammoleft": 4,
            "condition": "Battered",
            "hidden": false,
            "name": "Personal shield",
            "typeid": 35,
            "capacity": 50,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53953,
            "type": "armor",
            "wt": 3
        },
        {
            "ammoleft": 46,
            "condition": "Battered",
            "hidden": false,
            "name": "Personal shield",
            "typeid": 35,
            "capacity": 50,
            "equipped": false,
            "damagetype": "e",
            "itemid": 54003,
            "type": "armor",
            "wt": 3
        },
        {
            "ammoleft": 31,
            "condition": "Operational",
            "hidden": false,
            "name": "Personal shield",
            "typeid": 35,
            "capacity": 50,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53995,
            "type": "armor",
            "wt": 3
        },
        {
            "ammoleft": 16,
            "condition": "Average",
            "hidden": false,
            "name": "Personal shield",
            "typeid": 35,
            "capacity": 50,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53951,
            "type": "armor",
            "wt": 3
        },
        {
            "ammoleft": 2,
            "condition": "To spec",
            "hidden": false,
            "name": "Personal shield",
            "typeid": 35,
            "capacity": 50,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53949,
            "type": "armor",
            "wt": 3
        },
        {
            "ammoleft": 24,
            "condition": "To spec",
            "hidden": false,
            "name": "Personal shield",
            "typeid": 35,
            "capacity": 50,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53982,
            "type": "armor",
            "wt": 3
        },
        {
            "ammoleft": 50,
            "condition": "To spec",
            "hidden": false,
            "name": "Personal shield",
            "typeid": 35,
            "capacity": 50,
            "equipped": true,
            "damagetype": "e",
            "itemid": 2319,
            "type": "armor",
            "wt": 3
        },
        {
            "ammoleft": 60,
            "condition": "Battered",
            "hidden": false,
            "name": "Riot armor",
            "typeid": 36,
            "capacity": 100,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53988,
            "type": "armor",
            "wt": 15
        },
        {
            "ammoleft": 81,
            "condition": "Battered",
            "hidden": false,
            "name": "Riot armor",
            "typeid": 36,
            "capacity": 100,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53964,
            "type": "armor",
            "wt": 15
        },
        {
            "ammoleft": 10,
            "condition": "Operational",
            "hidden": false,
            "name": "Riot armor",
            "typeid": 36,
            "capacity": 100,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53969,
            "type": "armor",
            "wt": 15
        },
        {
            "ammoleft": 96,
            "condition": "To spec",
            "hidden": false,
            "name": "Riot armor",
            "typeid": 36,
            "capacity": 100,
            "equipped": true,
            "damagetype": "p",
            "itemid": 2292,
            "type": "armor",
            "wt": 15
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Peach Schnapps",
            "typeid": 41,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53952,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Battered",
            "hidden": false,
            "name": "Peach Schnapps",
            "typeid": 41,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 54007,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Battered",
            "hidden": false,
            "name": "Peach Schnapps",
            "typeid": 41,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53975,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Battered",
            "hidden": false,
            "name": "Peach Schnapps",
            "typeid": 41,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53989,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Operational",
            "hidden": false,
            "name": "Peach Schnapps",
            "typeid": 41,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53994,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Average",
            "hidden": false,
            "name": "Peach Schnapps",
            "typeid": 41,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53966,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "To spec",
            "hidden": false,
            "name": "Peach Schnapps",
            "typeid": 41,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53962,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Vodka",
            "typeid": 37,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53957,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Broken",
            "hidden": false,
            "name": "Vodka",
            "typeid": 37,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53968,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Operational",
            "hidden": false,
            "name": "Vodka",
            "typeid": 37,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53996,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Average",
            "hidden": false,
            "name": "Vodka",
            "typeid": 37,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53948,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "To spec",
            "hidden": false,
            "name": "Vodka",
            "typeid": 37,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53971,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "To spec",
            "hidden": false,
            "name": "Vodka",
            "typeid": 37,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53983,
            "type": "booze",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Canned goods",
            "typeid": 47,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53956,
            "type": "food",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Battered",
            "hidden": false,
            "name": "Canned goods",
            "typeid": 47,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53976,
            "type": "food",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Battered",
            "hidden": false,
            "name": "Canned goods",
            "typeid": 47,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53973,
            "type": "food",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "To spec",
            "hidden": false,
            "name": "Canned goods",
            "typeid": 47,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53974,
            "type": "food",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Broken",
            "hidden": false,
            "name": "Desiccated meat",
            "typeid": 45,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53972,
            "type": "food",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Battered",
            "hidden": false,
            "name": "Desiccated meat",
            "typeid": 45,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53965,
            "type": "food",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Battered",
            "hidden": false,
            "name": "Desiccated meat",
            "typeid": 45,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 54005,
            "type": "food",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Operational",
            "hidden": false,
            "name": "Desiccated meat",
            "typeid": 45,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 54002,
            "type": "food",
            "wt": 1
        },
        {
            "ammoleft": 0,
            "condition": "Operational",
            "hidden": false,
            "name": "Desiccated meat",
            "typeid": 45,
            "capacity": 1,
            "equipped": false,
            "damagetype": "p",
            "itemid": 53985,
            "type": "food",
            "wt": 1
        },
        {
            "ammoleft": 4,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Energy pistol",
            "typeid": 26,
            "capacity": 10,
            "equipped": false,
            "damagetype": "e",
            "itemid": 54006,
            "type": "weapon",
            "wt": 3
        },
        {
            "ammoleft": 8,
            "condition": "Destroyed",
            "hidden": false,
            "name": "Energy pistol",
            "typeid": 26,
            "capacity": 10,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53999,
            "type": "weapon",
            "wt": 3
        },
        {
            "ammoleft": 7,
            "condition": "Broken",
            "hidden": false,
            "name": "Energy pistol",
            "typeid": 26,
            "capacity": 10,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53979,
            "type": "weapon",
            "wt": 3
        },
        {
            "ammoleft": 0,
            "condition": "To spec",
            "hidden": false,
            "name": "Energy pistol",
            "typeid": 26,
            "capacity": 10,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53987,
            "type": "weapon",
            "wt": 3
        },
        {
            "ammoleft": 1,
            "condition": "Broken",
            "hidden": false,
            "name": "Energy rifle",
            "typeid": 27,
            "capacity": 3,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53963,
            "type": "weapon",
            "wt": 10
        },
        {
            "ammoleft": 0,
            "condition": "Battered",
            "hidden": false,
            "name": "Energy rifle",
            "typeid": 27,
            "capacity": 3,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53984,
            "type": "weapon",
            "wt": 10
        },
        {
            "ammoleft": 1,
            "condition": "Battered",
            "hidden": false,
            "name": "Energy rifle",
            "typeid": 27,
            "capacity": 3,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53954,
            "type": "weapon",
            "wt": 10
        },
        {
            "ammoleft": 0,
            "condition": "Operational",
            "hidden": false,
            "name": "Energy rifle",
            "typeid": 27,
            "capacity": 3,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53960,
            "type": "weapon",
            "wt": 10
        },
        {
            "ammoleft": 0,
            "condition": "Operational",
            "hidden": false,
            "name": "Energy rifle",
            "typeid": 27,
            "capacity": 3,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53997,
            "type": "weapon",
            "wt": 10
        },
        {
            "ammoleft": 2,
            "condition": "Operational",
            "hidden": false,
            "name": "Energy rifle",
            "typeid": 27,
            "capacity": 3,
            "equipped": false,
            "damagetype": "e",
            "itemid": 54004,
            "type": "weapon",
            "wt": 10
        },
        {
            "ammoleft": 0,
            "condition": "Average",
            "hidden": false,
            "name": "Energy rifle",
            "typeid": 27,
            "capacity": 3,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53967,
            "type": "weapon",
            "wt": 10
        },
        {
            "ammoleft": 2,
            "condition": "Average",
            "hidden": false,
            "name": "Energy rifle",
            "typeid": 27,
            "capacity": 3,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53990,
            "type": "weapon",
            "wt": 10
        },
        {
            "ammoleft": 2,
            "condition": "To spec",
            "hidden": false,
            "name": "Energy rifle",
            "typeid": 27,
            "capacity": 3,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53981,
            "type": "weapon",
            "wt": 10
        },
        {
            "ammoleft": 2,
            "condition": "To spec",
            "hidden": false,
            "name": "Energy rifle",
            "typeid": 27,
            "capacity": 3,
            "equipped": false,
            "damagetype": "e",
            "itemid": 53993,
            "type": "weapon",
            "wt": 10
        },
        {
            "ammoleft": 3,
            "condition": "To spec",
            "hidden": false,
            "name": "Energy rifle",
            "typeid": 27,
            "capacity": 3,
            "equipped": true,
            "damagetype": "e",
            "itemid": 53821,
            "type": "weapon",
            "wt": 10
        }
    ]
    </code>
    **/

public class Poll
{
  public static final String KEY = Poll.class.getName();
  public static final Logger log = Logger.getLogger(KEY);

  protected static final String ERROR = buildErrorJson();

  private static String buildErrorJson()
  {
    JSONObject ret = new JSONObject();
    try
    {
      JSONObject error = new JSONObject();
      error.put("message", "There has been an error retrieving the status");
      error.put("type", "error");
      ret.put("announce", error);
    }
    catch (JSONException e)
    {
      return null;
    }
    return String.valueOf(ret);
  }

  public static void fullPoll(Writer out, Whatzit wazzit, JSONArray alerts)
  {
    InvasionConnection conn = null;
    try
    {
      conn = new InvasionConnection();
      fullPoll(conn, out, wazzit, alerts);
    }
    catch (Exception e)
    {
      log.throwing(KEY, "Error occurred during polling", e);
      try { out.write(ERROR);
      }
      catch (Exception ee) {}
    }
    finally {
      conn.close();
    }
  }

  public static void fullPoll(InvasionConnection conn, Writer out, Whatzit wazzit, JSONArray alerts)
  {
    log.entering(KEY, "fullPoll");
    long start = System.currentTimeMillis();
    log.finer(start + "");
    try
    {
      JSONObject ret = new JSONObject();

      ret.put("stats", Alt.getStats(conn, wazzit.getAlt().getId()));
      log.finer("Stats complete: " + (System.currentTimeMillis() - start));

      JSONArray items = Item.getItems(conn, wazzit.getAlt().getId());
      if (items.length() > 0)
      {
        ret.put("inv", items);
      }
      log.finer("Items complete: " + (System.currentTimeMillis() - start));

      ret.put("msgs", Message.getInitialMessages(conn, wazzit.getAlt().getId()));

      JSONArray occupants = Location.getOccupants(conn, wazzit.getAlt().getLocation(), wazzit.getAlt());
      if (occupants.length() > 0)
      {
        ret.put("occs", occupants);
      }
      log.finer("Occupants complete: " + (System.currentTimeMillis() - start));

      if ((alerts != null) && (alerts.length() > 0))
      {
        ret.put("announce", alerts);
      }

      JSONArray pets = BroodManager.petsAtLocation(wazzit.getAlt());
      if (pets.length() > 0)
      {
        ret.put("pets", pets);
      }
      log.finer("Pets complete: " + (System.currentTimeMillis() - start));

      ret.put("location", Location.getSummary(conn, wazzit.getAlt()));

      items = Item.getItems(conn, wazzit.getAlt().getLocation());
      if (items.length() > 0)
      {
        ret.put("ground", items);
      }
      log.finer("Location items complete: " + (System.currentTimeMillis() - start));
      log.finer("Poll results: " + ret);
      out.write(String.valueOf(ret));
    }
    catch (Exception e)
    {
      log.throwing(KEY, "Error occurred during polling", e);
      try { out.write(ERROR); } catch (Exception ee) {}
      return;
    }
    log.finer("Exiting: " + (System.currentTimeMillis() - start));
  }

  public static void sendReloadCommand(Writer out)
  {
    try
    {
      JSONObject ret = new JSONObject();
      ret.put("reload", true);
      out.write(String.valueOf(ret));
    }
    catch (Exception e)
    {
      log.throwing(KEY, "Error occurred during polling", e);
      try { out.write(ERROR); } catch (Exception ee) {}
      return;
    }
  }

  public static JSONObject createErrorAlert(String message)
  {
    try
    {
      JSONObject ret = new JSONObject();
      ret.put("type", "error");
      ret.put("message", message);
      return ret;
    }
    catch (JSONException e) {}

    return null;
  }

  public static JSONObject createInfoAlert(String message)
  {
    try
    {
      JSONObject ret = new JSONObject();
      ret.put("type", "info");
      ret.put("message", message);
      return ret;
    }
    catch (JSONException e) {}

    return null;
  }
}
