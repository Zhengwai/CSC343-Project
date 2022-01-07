import psycopg2 as pg
db_conn = pg.connect(dbname='csc343h-songgua7',user='songgua7', options='-c search_path=solarsystem')
cur = db_conn.cursor()
disc_num = []
i = 1600
while i<2050:
	cur.execute("""select count(*) from discovered where discovery_date between '%s-01-01 00:00:00' and '%s-01-01 00:00:00';""", (i, i+50))
	disc_num.append(cur.fetchall()[0][0])
	i += 50
#print(disc_num)
cur.execute("select escape_speed, mass/cbrt(volume) from planet union select escape_speed, mass/cbrt(volume) from largemoon;")
array = cur.fetchall()
#print(array)
cur.execute("select gravity, mass/cbrt(volume)/cbrt(volume) from planet union select gravity, mass/cbrt(volume)/cbrt(volume) from largemoon;")
array2 = cur.fetchall()
cur.execute("""select parent_body, gravity, count(satellite) 
    from orbit join planet on parent_body=bid 
    group by parent_body, gravity;""")
array3 = cur.fetchall()
cur.close()
db_conn.close()
db_conn.close()