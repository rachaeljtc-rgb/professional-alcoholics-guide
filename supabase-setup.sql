-- ══════════════════════════════════════════════════
-- NOT-SO-PROFESSIONAL ALCOHOLIC'S GUIDE
-- Paste this into Supabase > SQL Editor > Run
-- ══════════════════════════════════════════════════

create table if not exists places (
  id         serial primary key,
  type       text not null default 'bar',
  name       text not null,
  city       text,
  lat        float,
  lng        float,
  visited    boolean default false,
  rating     float,
  reviews    text,
  vibe       text,
  vibes      text[],
  photo      text,
  created_at timestamptz default now()
);

create table if not exists recipes (
  id          serial primary key,
  name        text not null,
  origin      text,
  badge       text,
  description text,
  ingredients text,
  method      text,
  photo       text,
  created_at  timestamptz default now()
);

-- Allow public read access (your main site is public)
alter table places  enable row level security;
alter table recipes enable row level security;

create policy "Public read places"  on places  for select using (true);
create policy "Public read recipes" on recipes for select using (true);

-- Allow full access with the anon key (your admin uses this)
create policy "Anon all places"  on places  for all using (true) with check (true);
create policy "Anon all recipes" on recipes for all using (true) with check (true);


-- ══════════════════════════════════════════════════
-- SEED: your current bars & restaurants
-- Run this AFTER the tables are created
-- ══════════════════════════════════════════════════

insert into places (type,name,city,lat,lng,visited,rating,reviews,vibe,vibes,photo) values
('bar','Youngblood','San Diego, CA',32.7343,-117.1443,true,4.5,'320','Cool, unpretentious. Doesn''t try too hard and doesn''t need to. Good for a low-key night with people you actually like.',array['social','solo'],'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?w=600&q=75'),
('bar','Satan''s Whiskers','London, UK',51.5280,-0.0614,true,4.6,'890','Tiny, dimly lit, very serious about cocktails. They''ll make you something weird and you''ll love it.',array['fancy','date','solo'],'https://images.unsplash.com/photo-1470337458703-46ad1756a187?w=600&q=75'),
('bar','Tayer + Elementary','London, UK',51.5265,-0.0838,true,4.7,'640','Genuinely world-class. The kind of bar that makes you rethink your whole relationship with drinking.',array['fancy','date'],'https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=600&q=75'),
('bar','Overstory','New York, NY',40.7115,-74.0130,true,4.4,'1.2K','Rooftop with a view that takes your breath away. Seasonal drinks. Go at golden hour.',array['fancy','date','social'],'https://images.unsplash.com/photo-1566417713940-fe7c737a9ef2?w=600&q=75'),
('bar','Please Don''t Tell','New York, NY',40.7264,-73.9849,false,4.6,'2.1K','You enter through a phone booth in a hot dog restaurant. The concept alone is worth the trip.',array['date','social','fancy'],'https://images.unsplash.com/photo-1527661591475-527312dd65f5?w=600&q=75'),
('bar','Bar Termini','London, UK',51.5136,-0.1316,false,4.5,'730','Italian aperitivo hour done properly. Negronis and tiny snacks. I want this to be my regular.',array['solo','fancy','date'],'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=600&q=75'),
('bar','Dante','New York, NY',40.7299,-74.0030,false,4.5,'3.4K','One of the best bars in the world. Spritzes and pasta in the West Village. Classic for a reason.',array['social','date','fancy'],'https://images.unsplash.com/photo-1559329007-40df8a9345d8?w=600&q=75'),
('bar','Pacific Standard','San Diego, CA',32.7536,-117.1592,false,4.3,'410','The craft cocktail bar in SD I keep meaning to go to. No car problem applies.',array['solo','date','fancy'],'https://images.unsplash.com/photo-1582106245687-cbb466a9f07f?w=600&q=75'),
('restaurant','Jeune et Jolie','Carlsbad, CA',33.1581,-117.3506,true,4.6,'870','French-ish California food that''s romantic without being stiff. The kind of dinner that makes you feel like you have your life together.',array['fancy','date'],'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=600&q=75'),
('restaurant','Bestia','Los Angeles, CA',34.0402,-118.2336,false,4.6,'4.2K','Italian-ish in the Arts District. Loud, buzzy, incredible pasta. You need a reservation but it''s worth the planning.',array['social','fancy'],'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=600&q=75'),
('restaurant','Dishoom','London, UK',51.5126,-0.1235,false,4.7,'18K','Bombay café culture done with so much love. The bacon naan at breakfast is life-changing. Always a queue. Always worth it.',array['social','solo'],'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=600&q=75'),
('restaurant','Cote de Boeuf','San Diego, CA',32.7220,-117.1570,false,4.4,'290','French steakhouse energy in SD. The sort of place where you order a carafe of wine and lose track of time.',array['fancy','date'],'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=600&q=75');

insert into recipes (name,origin,badge,description,ingredients,method,photo) values
('Aperol Spritz','Veneto, Italy','3 ingredients','The drink that unlocked aperitivo culture for me. Slightly bitter, very orange, impossible to have just one.','3 oz prosecco · 2 oz Aperol · 1 oz soda water · orange slice','Build in a wine glass over ice. Prosecco first, then Aperol, then soda. Stir gently. Add the orange. That''s genuinely it.','https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=600&q=75'),
('Negroni','Florence, Italy','equal parts','One part gin, one part Campari, one part sweet vermouth. Sounds too simple. Tastes like a decision.','1 oz gin · 1 oz Campari · 1 oz sweet vermouth · orange peel','Stir over ice until very cold. Strain into a rocks glass over a large ice cube. Express the orange peel. Do not rush this.','https://images.unsplash.com/photo-1574634534894-89d7576c8259?w=600&q=75'),
('Paper Plane','Sasha Petraske, NYC','equal parts','Bourbon, Aperol, amaro, lemon — equal parts of everything. Shouldn''t work. Does. I think about it a lot.','¾ oz bourbon · ¾ oz Aperol · ¾ oz Amaro Nonino · ¾ oz fresh lemon juice','Shake hard with ice. Strain into a coupe. No garnish. It''s perfect as written.','https://images.unsplash.com/photo-1543254836-a9c293a3dc26?w=600&q=75'),
('Tommy''s Margarita','Tommy''s, San Francisco','the upgrade','Agave syrup instead of triple sec. One change. Makes it smoother, more honest. The correct margarita.','2 oz blanco tequila · 1 oz fresh lime juice · ½ oz agave syrup · salt (optional)','Shake hard. Strain over fresh ice. Salt the rim if you want. Both choices are correct.','https://images.unsplash.com/photo-1609345265499-2134f8b400a5?w=600&q=75');
