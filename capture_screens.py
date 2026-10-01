import os
import sys
import subprocess
import urllib.parse
import urllib.request
import http.cookiejar

sys.stdout.reconfigure(encoding='utf-8')

edge_path = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
screenshot_dir = r"C:\Users\Will\Documents\workspace-spring-tools-for-eclipse-5.3.0.RELEASE\24110330_04\doc_screenshots"
os.makedirs(screenshot_dir, exist_ok=True)

public_pages = [
    ("cau1_home.png", "http://localhost:8080/24110330_04/home"),
    ("cau2_login.png", "http://localhost:8080/24110330_04/login"),
    ("cau2_register.png", "http://localhost:8080/24110330_04/register"),
    ("cau2_verify_otp.png", "http://localhost:8080/24110330_04/verify-otp"),
    ("cau4_video_detail.png", "http://localhost:8080/24110330_04/video/detail?id=V01"),
    ("cau5_category_p1.png", "http://localhost:8080/24110330_04/videos/category?id=1&page=1"),
    ("cau5_category_p2.png", "http://localhost:8080/24110330_04/videos/category?id=1&page=2"),
]

print("Bat dau chup cac trang public...")
for filename, url in public_pages:
    out_path = os.path.join(screenshot_dir, filename)
    cmd = [
        edge_path,
        "--headless",
        "--disable-gpu",
        "--no-sandbox",
        f"--screenshot={out_path}",
        "--window-size=1280,900",
        url
    ]
    subprocess.run(cmd, capture_output=True)
    print(f"Da chup: {filename}")

# Chup trang admin
print("Dang nhap Admin de chup cac trang quan tri...")
cj = http.cookiejar.CookieJar()
opener = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(cj))

login_data = urllib.parse.urlencode({'username': 'admin', 'password': '123456'}).encode('utf-8')
login_req = urllib.request.Request("http://localhost:8080/24110330_04/login", data=login_data)
try:
    opener.open(login_req)
except Exception as e:
    pass

admin_pages = [
    ("cau1_admin_home.png", "http://localhost:8080/24110330_04/admin/home"),
    ("cau3_admin_users_p1.png", "http://localhost:8080/24110330_04/admin/users?page=1"),
    ("cau3_admin_users_p2.png", "http://localhost:8080/24110330_04/admin/users?page=2"),
    ("cau3_admin_user_form.png", "http://localhost:8080/24110330_04/admin/user/create")
]

for filename, url in admin_pages:
    try:
        req = urllib.request.Request(url)
        resp = opener.open(req)
        html_content = resp.read().decode('utf-8')
        html_content = html_content.replace('/24110330_04/', 'http://localhost:8080/24110330_04/')
        
        tmp_html = os.path.join(screenshot_dir, "temp_" + filename.replace(".png", ".html"))
        with open(tmp_html, "w", encoding="utf-8") as f:
            f.write(html_content)
        
        out_path = os.path.join(screenshot_dir, filename)
        file_url = "file:///" + tmp_html.replace("\\", "/")
        cmd = [
            edge_path,
            "--headless",
            "--disable-gpu",
            "--no-sandbox",
            f"--screenshot={out_path}",
            "--window-size=1280,900",
            file_url
        ]
        subprocess.run(cmd, capture_output=True)
        print(f"Da chup admin: {filename}")
    except Exception as e:
        print(f"Loi chup {filename}: {e}")

print("Hoan tat chup man hinh tat ca cac cau!")
