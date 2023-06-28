from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL
app = Flask(__name__)

mysql = MySQL(app)
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'Shamanth@25'
app.config['MYSQL_DB'] = 'ipl'
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'


@app.route("/", methods=["POST", "GET"])
@app.route("/sign%in/", methods=["POST", "GET"])
def sign_in():
    if request.method == "POST":
        cur = mysql.connection.cursor()
        usrnm = request.form["username"]
        passwd = request.form["password"]
        # sql = " SELECT * FROM login_info WHERE USERNAME = %s AND PASSWORD = %s "
        # cur.execute(sql, (usrnm, passwd))
        # sqld = cur.fetchall()
        # # print(sqld)
        # if len(sqld) != 0:
        if usrnm == "user" and passwd == "user123":
            return redirect("/home%page/")
        else:
            return render_template("sign-in.html")

    else:
        return render_template("sign-in.html")


@app.route("/home/")
@app.route("/home%page/")
def home():
    return render_template("home-page.html")


@app.route("/about/")
def about():
    return render_template("about.html")


@app.route("/player%stats/")
def player_stats():
    cur = mysql.connection.cursor()
    cur.execute(''' CALL team_details(\'RCB\') ''')
    rcb_details = cur.fetchall()
    cur.execute(''' CALL team_details(\'SRH\') ''')
    srh_details = cur.fetchall()
    cur.execute(''' SELECT p.player_id, p.player_name, p.player_role, innings, runs, wickets, 50s, 100s, 3wh  
                    FROM PLAYER p,STATS s WHERE s.player_id=p.player_id and p.TEAM_ID = \'RCB\' ''')
    rcb = cur.fetchall()
    cur.execute(''' SELECT p.player_id, p.player_name, p.player_role, innings, runs, wickets, 50s, 100s, 3wh  
                        FROM PLAYER p,STATS s WHERE s.player_id=p.player_id and p.TEAM_ID = \'SRH\' ''')
    srh = cur.fetchall()
    return render_template("player-stats.html", rcb=rcb, srh=srh, rcbd=rcb_details[0], srhd=srh_details[0])


@app.route("/all%player%stats/")
def all_player_stats():
    cur = mysql.connection.cursor()
    cur.execute(''' SELECT player_id, player_name, player_role FROM PLAYER WHERE team_id = \'RCB\' ''')
    rcb = cur.fetchall()
    cur.execute(''' SELECT player_id, player_name, player_role FROM PLAYER WHERE team_id = \'SRH\' ''')
    srh = cur.fetchall()
    return render_template("player-records.html", rcb=rcb, srh=srh)


@app.route("/points%table/")
def points_table():
    cur = mysql.connection.cursor()
    cur.execute(''' SELECT team_id from team ORDER BY points DESC ''')
    teams = cur.fetchall()
    team_point = []
    for team in teams:
        proc_call = " call points_table(%s) "
        cur.execute(proc_call, [team['team_id']])
        team_point.append(cur.fetchall())
    # print(team_point[1][0])
    return render_template("points-table.html", pts=team_point)


@app.route("/matches/")
def matches():
    cur = mysql.connection.cursor()
    cur.execute(''' SELECT * FROM match_details ''')
    mat = cur.fetchall()
    print(mat)
    return render_template("matches.html", match=mat)


@app.route("/staff/")
def staff():
    cur = mysql.connection.cursor()
    cur.execute(''' SELECT staff_name, staff_role FROM STAFF WHERE team_id = \'RCB\' ''')
    rcb = cur.fetchall()
    # print(rcb)
    cur.execute(''' SELECT staff_name, staff_role FROM STAFF WHERE team_id = \'SRH\' ''')
    srh = cur.fetchall()
    # print(srh)
    return render_template("staff.html", rcb=rcb, srh=srh)


@app.route("/register/", methods=["POST", "GET"])
def register():
    if request.method == "POST":
        email = request.form["email_id"]
        passwd = request.form["password"]
        fnm = request.form["fname"]
        lnm = request.form["lname"]
        usrnm = request.form["username"]
        print(fnm)
        print(lnm)
        print(usrnm)
        print(email)
        print(passwd)
        cur = mysql.connection.cursor()
        cur.execute(" INSERT INTO login_info VALUES(%s, %s, %s, %s, %s)", (fnm, lnm, usrnm, email, passwd))
        mysql.connection.commit()
        return "<h1>done!</h1>"
    else:
        return render_template("register.html")


if __name__ == '__main__':
    app.debug = True
    app.run()
