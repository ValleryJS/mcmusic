local githubUrl = "https://raw.githubusercontent.com/username/repo/branch/path/to/audio/file.nbs" -- Replace with the actual GitHub raw file URL
local audioFile = "file.nbs" -- Name of the downloaded audio file
local stopFlagFile = "stop.txt" -- File to signal the program to stop

-- Download audio file from GitHub
local response = http.get(githubUrl)
if response then
    local file = fs.open(audioFile, "w")
    file.write(response.readAll())
    file.close()
    response.close()
    print("Audio file downloaded successfully.")
else
    print("Failed to download audio file.")
    return
end

-- Function to check if stop command is received
local function checkStopCommand()
    if fs.exists(stopFlagFile) then
        return true
    end
    return false
end

-- Play audio file on repeat until stop command is received
while not checkStopCommand() do
    speaker.playFile(audioFile)
end

-- Cleanup: delete the audio file
fs.delete(audioFile)
speaker.stopAll()
print("Program stopped.")
