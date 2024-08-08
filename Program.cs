const string soundPath = "/usr/share/mint-artwork/sounds/plug.oga";

if (!int.TryParse(args[0], out int delay)) {
    Console.WriteLine("Invalid Input");
    return;
}

if (delay <= 0)
    delay = 1;

long startEpoch = DateTimeOffset.UtcNow.ToUnixTimeSeconds();

long targetEpoch = startEpoch + delay;

while (DateTimeOffset.UtcNow.ToUnixTimeSeconds() < targetEpoch) {
    Thread.Sleep(1000);
    FormatTime(targetEpoch - DateTimeOffset.UtcNow.ToUnixTimeSeconds());
}

bool keepPlaying = true;
var inputThread = new Thread(() => {
    while (keepPlaying) {
        if (Console.ReadKey(true).Key == ConsoleKey.Q) {
            keepPlaying = false;
        }
    }
});
inputThread.Start();

Console.Clear();
Console.WriteLine("00:00:00");
Console.WriteLine("Press q to stop.");
while (keepPlaying) {
    PlaySound(soundPath);
}

return;

void FormatTime(long time) {
    long hours = time / 3600;
    long minutes = time % 3600 / 60;
    long seconds = time % 60;
    string formattedTime = $"{hours:D2}:{minutes:D2}:{seconds:D2}";
    Console.Clear();
    Console.Write(formattedTime);
}

void PlaySound(string sound) {
    var startInfo = new ProcessStartInfo {
        FileName = "play",
        Arguments = sound,
        RedirectStandardOutput = true,
        RedirectStandardError = true,
        UseShellExecute = false,
        CreateNoWindow = true
    };

    using var process = new Process();
    process.StartInfo = startInfo;
    process.Start();
    process.WaitForExit();
}