from yt_dlp import YoutubeDL

def get_playback_link(url):
    ydl_opts = {
        "quiet": True,
        "skip_download": True,
    }
    with YoutubeDL(ydl_opts) as ydl:
        info = ydl.extract_info(url, download=False)
        formats = info.get("formats", [])

        print("\n=== Playback Links ===")
        for f in formats:
            if "url" in f:
                print(f"itag {f['format_id']} | {f['ext']} | {f.get('height', 'audio')}p | {f['url']}")

if __name__ == "__main__":
    # taruh link YT di sini sebagai string
    video_url = "https://www.youtube.com/watch?v=iCkWAGWTk40"
    get_playback_link(video_url)
