import ballerina/io;
import ballerina/log;
import ballerina/math;


function closeRc(io:ReadableCharacterChannel rc) {
    var result = rc.close();
    if (result is error) {
        log:printError("Error occurred while closing character stream",
                        err = result);
    }
}

function closeWc(io:WritableCharacterChannel wc) {
    var result = wc.close();
    if (result is error) {
        log:printError("Error occurred while closing character stream",
                        err = result);
    }
}

function write(json content, string path) returns @tainted error? {

    io:WritableByteChannel wbc = check io:openWritableFile(path);

    io:WritableCharacterChannel wch = new (wbc, "UTF8");
    var result = wch.writeJson(content);
    closeWc(wch);
    return result;
}



function read(string path) returns @tainted json|error {

    io:ReadableByteChannel rbc = check io:openReadableFile(path);

    io:ReadableCharacterChannel rch = new (rbc, "UTF8");
    var result = rch.readJson();
    closeRc(rch);
    return result;
}


type hash record {
    string hashkey;
};

type artist record {
    string name;
};

type album record {
    string title;
};

type song record {
    string title;
    string genre;
    string platform;
};

type platform record {
    string platform;
};

type _mainrec_ record {
    hash hashkey;
    artist artist;
    album album;
    song song;
    platform platform;
};

function getRecord() {

}

function checkRecord() {

    

    string filepath = "data.json";

    var rResult = read(filepath);
        if (rResult is error) {
            log:printError("Error occurred while reading json: ",
                            err = rResult);
        } else {
            io:println("checking for duplicate record");
            io:println(rResult.toJsonString());
        }
}

function updateRecord() {

    io:println("Record Update");
    io:println("_____________");
    io:println(" ");
    string artist_name = io:readln("Enter artist name: ");
    string artist_album = io:readln("Enter album name: ");
    string song_title = io:readln("Enter song title: ");
    string song_genre = io:readln("Enter song genre: ");
    string song_platform = io:readln("Enter the platform name: ");
    io:println("...");

    string filepath = "data.json";

    json j1 = {
        hash: "1",
        artist: [
            {
                name: artist_name
            }
        ],
        album: artist_album,
        songs: [
            {
                title: song_title,
                genre: song_genre,
                platform: song_platform
            }
        ]
    };

    io:println("Preparing to write to json");
    
    var wResult = write(j1, filepath);
    if (wResult is error) {
        log:printError("Error occurred while writing json: ", wResult);
    } else {
        io:println("Record successfully updated");
    }

    var rResult = read(filepath);
        if (rResult is error) {
            log:printError("Error occurred while reading json: ",
                            err = rResult);
        } else {
            io:println(rResult.toJsonString());
        }

}



function updateRecordtest() {

    
    io:println("Record Update");
    io:println("_____________");
    io:println(" ");
    string artist_name = io:readln("Enter artist name: ");
    string artist_album = io:readln("Enter album name: ");
    string song_title = io:readln("Enter song title: ");
    string song_genre = io:readln("Enter song genre: ");
    string song_platform = io:readln("Enter the platform name: ");

    string filepath = "data.json";
    
    int|error hashkey = math:randomInRange(1,100);
    string hash = hashkey.toString();

    json j1 = {
        hash: hash,
        artist: [
            {
                name: artist_name
            }
        ],
        album: artist_album,
        songs: [
            {
                title: song_title,
                genre: song_genre,
                platform: song_platform
            }
        ]
    };

    io:println("Preparing to write to json");
    
    var wResult = write(j1, filepath);
    if (wResult is error) {
        log:printError("Error occurred while writing json: ", wResult);
    } else {
        io:println("Record successfully updated");
    }

    var rResult = read(filepath);
        if (rResult is error) {
            log:printError("Error occurred while reading json: ",
                            err = rResult);
        } else {
            io:println(rResult.toJsonString());
        }

}



public function main() {
    
    updateRecordtest();

}