////////////////////////////////////////////////////////////////////////////////
// ROM
////////////////////////////////////////////////////////////////////////////////

fn lfsr8(n: u8) -> u8 {
  n[0+:u7] ++ (n[3+:u1] ^ n[4+:u1] ^ n[5+:u1] ^ n[7+:u1])
}

fn get_rom(address: u16) -> u8 {
  match address {
		u16:0x0000 => u8:0xf0,
		u16:0x0001 => u8:0x41,
		u16:0x0002 => u8:0xcb,
		u16:0x0003 => u8:0x57,
		u16:0x0004 => u8:0xc8,
		u16:0x0005 => u8:0x47,
		u16:0x0006 => u8:0x3e,
		u16:0x0007 => u8:0x8,
		u16:0x0008 => u8:0xe0,
		u16:0x0009 => u8:0x41,
		u16:0x000a => u8:0x78,
		u16:0x000b => u8:0xe6,
		u16:0x000c => u8:0x3,
		u16:0x000d => u8:0xc0,
		u16:0x000e => u8:0xf0,
		u16:0x000f => u8:0x44,
		u16:0x0010 => u8:0xfe,
		u16:0x0011 => u8:0x2f,
		u16:0x0012 => u8:0x20,
		u16:0x0013 => u8:0xe,
		u16:0x0014 => u8:0xfa,
		u16:0x0015 => u8:0x2,
    _ => u8:0x00,
  }
}

fn get_data(address: u16) -> u8 {
  let result = if address >= u16:0x2001 && address < u16:0x2100 {
    lfsr8(address[0+:u8])
  } else {
    get_rom(address)
  };
  result
}

////////////////////////////////////////////////////////////////////////////////
// Public
////////////////////////////////////////////////////////////////////////////////

pub fn user_module(io_in: u24) -> u8 {
  get_data(io_in[3+:u16])
}

////////////////////////////////////////////////////////////////////////////////
// Tests
////////////////////////////////////////////////////////////////////////////////

#[test]
fn rom_test() {
  let _ = assert_eq(get_data(u16:0x0000), u8:0xf0);
  let _ = assert_eq(get_data(u16:0x0001), u8:0x41);
  let _ = assert_eq(get_data(u16:0x0002), u8:0xcb);
  let _ = assert_eq(get_data(u16:0x0003), u8:0x57);
  let _ = assert_eq(get_data(u16:0x0004), u8:0xc8);
  let _ = assert_eq(get_data(u16:0x0005), u8:0x47);
  let _ = assert_eq(get_data(u16:0x0006), u8:0x3e);
  let _ = assert_eq(get_data(u16:0x0007), u8:0x8);
  let _ = assert_eq(get_data(u16:0x0008), u8:0xe0);
  let _ = assert_eq(get_data(u16:0x0009), u8:0x41);
  let _ = assert_eq(get_data(u16:0x000a), u8:0x78);
  let _ = assert_eq(get_data(u16:0x000b), u8:0xe6);
  let _ = assert_eq(get_data(u16:0x000c), u8:0x3);
  let _ = assert_eq(get_data(u16:0x000d), u8:0xc0);
  let _ = assert_eq(get_data(u16:0x000e), u8:0xf0);
  let _ = assert_eq(get_data(u16:0x000f), u8:0x44);
  let _ = assert_eq(get_data(u16:0x0010), u8:0xfe);
  let _ = assert_eq(get_data(u16:0x0011), u8:0x2f);
  let _ = assert_eq(get_data(u16:0x0012), u8:0x20);
  let _ = assert_eq(get_data(u16:0x0013), u8:0xe);
  let _ = assert_eq(get_data(u16:0x0014), u8:0xfa);
  let _ = assert_eq(get_data(u16:0x0015), u8:0x2);
}

#[test]
fn lfsr_test() {
  let _ = assert_eq(get_data(u16:0x2000 + u16:1), u8:2);
  let _ = assert_eq(get_data(u16:0x2000 + u16:2), u8:4);
  let _ = assert_eq(get_data(u16:0x2000 + u16:4), u8:8);
  let _ = assert_eq(get_data(u16:0x2000 + u16:8), u8:17);
  let _ = assert_eq(get_data(u16:0x2000 + u16:17), u8:35);
  let _ = assert_eq(get_data(u16:0x2000 + u16:35), u8:71);
  let _ = assert_eq(get_data(u16:0x2000 + u16:71), u8:142);
  let _ = assert_eq(get_data(u16:0x2000 + u16:142), u8:28);
  let _ = assert_eq(get_data(u16:0x2000 + u16:28), u8:56);
  let _ = assert_eq(get_data(u16:0x2000 + u16:56), u8:113);
  let _ = assert_eq(get_data(u16:0x2000 + u16:113), u8:226);
  let _ = assert_eq(get_data(u16:0x2000 + u16:226), u8:196);
  let _ = assert_eq(get_data(u16:0x2000 + u16:196), u8:137);
  let _ = assert_eq(get_data(u16:0x2000 + u16:137), u8:18);
  let _ = assert_eq(get_data(u16:0x2000 + u16:18), u8:37);
  let _ = assert_eq(get_data(u16:0x2000 + u16:37), u8:75);
  let _ = assert_eq(get_data(u16:0x2000 + u16:75), u8:151);
  let _ = assert_eq(get_data(u16:0x2000 + u16:151), u8:46);
  let _ = assert_eq(get_data(u16:0x2000 + u16:46), u8:92);
  let _ = assert_eq(get_data(u16:0x2000 + u16:92), u8:184);
  let _ = assert_eq(get_data(u16:0x2000 + u16:184), u8:112);
  let _ = assert_eq(get_data(u16:0x2000 + u16:112), u8:224);
  let _ = assert_eq(get_data(u16:0x2000 + u16:224), u8:192);
  let _ = assert_eq(get_data(u16:0x2000 + u16:192), u8:129);
  let _ = assert_eq(get_data(u16:0x2000 + u16:129), u8:3);
  let _ = assert_eq(get_data(u16:0x2000 + u16:3), u8:6);
  let _ = assert_eq(get_data(u16:0x2000 + u16:6), u8:12);
  let _ = assert_eq(get_data(u16:0x2000 + u16:12), u8:25);
  let _ = assert_eq(get_data(u16:0x2000 + u16:25), u8:50);
  let _ = assert_eq(get_data(u16:0x2000 + u16:50), u8:100);
  let _ = assert_eq(get_data(u16:0x2000 + u16:100), u8:201);
  let _ = assert_eq(get_data(u16:0x2000 + u16:201), u8:146);
  let _ = assert_eq(get_data(u16:0x2000 + u16:146), u8:36);
  let _ = assert_eq(get_data(u16:0x2000 + u16:36), u8:73);
  let _ = assert_eq(get_data(u16:0x2000 + u16:73), u8:147);
  let _ = assert_eq(get_data(u16:0x2000 + u16:147), u8:38);
  let _ = assert_eq(get_data(u16:0x2000 + u16:38), u8:77);
  let _ = assert_eq(get_data(u16:0x2000 + u16:77), u8:155);
  let _ = assert_eq(get_data(u16:0x2000 + u16:155), u8:55);
  let _ = assert_eq(get_data(u16:0x2000 + u16:55), u8:110);
  let _ = assert_eq(get_data(u16:0x2000 + u16:110), u8:220);
  let _ = assert_eq(get_data(u16:0x2000 + u16:220), u8:185);
  let _ = assert_eq(get_data(u16:0x2000 + u16:185), u8:114);
  let _ = assert_eq(get_data(u16:0x2000 + u16:114), u8:228);
  let _ = assert_eq(get_data(u16:0x2000 + u16:228), u8:200);
  let _ = assert_eq(get_data(u16:0x2000 + u16:200), u8:144);
  let _ = assert_eq(get_data(u16:0x2000 + u16:144), u8:32);
  let _ = assert_eq(get_data(u16:0x2000 + u16:32), u8:65);
  let _ = assert_eq(get_data(u16:0x2000 + u16:65), u8:130);
  let _ = assert_eq(get_data(u16:0x2000 + u16:130), u8:5);
  let _ = assert_eq(get_data(u16:0x2000 + u16:5), u8:10);
  let _ = assert_eq(get_data(u16:0x2000 + u16:10), u8:21);
  let _ = assert_eq(get_data(u16:0x2000 + u16:21), u8:43);
  let _ = assert_eq(get_data(u16:0x2000 + u16:43), u8:86);
  let _ = assert_eq(get_data(u16:0x2000 + u16:86), u8:173);
  let _ = assert_eq(get_data(u16:0x2000 + u16:173), u8:91);
  let _ = assert_eq(get_data(u16:0x2000 + u16:91), u8:182);
  let _ = assert_eq(get_data(u16:0x2000 + u16:182), u8:109);
  let _ = assert_eq(get_data(u16:0x2000 + u16:109), u8:218);
  let _ = assert_eq(get_data(u16:0x2000 + u16:218), u8:181);
  let _ = assert_eq(get_data(u16:0x2000 + u16:181), u8:107);
  let _ = assert_eq(get_data(u16:0x2000 + u16:107), u8:214);
  let _ = assert_eq(get_data(u16:0x2000 + u16:214), u8:172);
  let _ = assert_eq(get_data(u16:0x2000 + u16:172), u8:89);
  let _ = assert_eq(get_data(u16:0x2000 + u16:89), u8:178);
  let _ = assert_eq(get_data(u16:0x2000 + u16:178), u8:101);
  let _ = assert_eq(get_data(u16:0x2000 + u16:101), u8:203);
  let _ = assert_eq(get_data(u16:0x2000 + u16:203), u8:150);
  let _ = assert_eq(get_data(u16:0x2000 + u16:150), u8:44);
  let _ = assert_eq(get_data(u16:0x2000 + u16:44), u8:88);
  let _ = assert_eq(get_data(u16:0x2000 + u16:88), u8:176);
  let _ = assert_eq(get_data(u16:0x2000 + u16:176), u8:97);
  let _ = assert_eq(get_data(u16:0x2000 + u16:97), u8:195);
  let _ = assert_eq(get_data(u16:0x2000 + u16:195), u8:135);
  let _ = assert_eq(get_data(u16:0x2000 + u16:135), u8:15);
  let _ = assert_eq(get_data(u16:0x2000 + u16:15), u8:31);
  let _ = assert_eq(get_data(u16:0x2000 + u16:31), u8:62);
  let _ = assert_eq(get_data(u16:0x2000 + u16:62), u8:125);
  let _ = assert_eq(get_data(u16:0x2000 + u16:125), u8:251);
  let _ = assert_eq(get_data(u16:0x2000 + u16:251), u8:246);
  let _ = assert_eq(get_data(u16:0x2000 + u16:246), u8:237);
  let _ = assert_eq(get_data(u16:0x2000 + u16:237), u8:219);
  let _ = assert_eq(get_data(u16:0x2000 + u16:219), u8:183);
  let _ = assert_eq(get_data(u16:0x2000 + u16:183), u8:111);
  let _ = assert_eq(get_data(u16:0x2000 + u16:111), u8:222);
  let _ = assert_eq(get_data(u16:0x2000 + u16:222), u8:189);
  let _ = assert_eq(get_data(u16:0x2000 + u16:189), u8:122);
  let _ = assert_eq(get_data(u16:0x2000 + u16:122), u8:245);
  let _ = assert_eq(get_data(u16:0x2000 + u16:245), u8:235);
  let _ = assert_eq(get_data(u16:0x2000 + u16:235), u8:215);
  let _ = assert_eq(get_data(u16:0x2000 + u16:215), u8:174);
  let _ = assert_eq(get_data(u16:0x2000 + u16:174), u8:93);
  let _ = assert_eq(get_data(u16:0x2000 + u16:93), u8:186);
  let _ = assert_eq(get_data(u16:0x2000 + u16:186), u8:116);
  let _ = assert_eq(get_data(u16:0x2000 + u16:116), u8:232);
  let _ = assert_eq(get_data(u16:0x2000 + u16:232), u8:209);
  let _ = assert_eq(get_data(u16:0x2000 + u16:209), u8:162);
  let _ = assert_eq(get_data(u16:0x2000 + u16:162), u8:68);
  let _ = assert_eq(get_data(u16:0x2000 + u16:68), u8:136);
  let _ = assert_eq(get_data(u16:0x2000 + u16:136), u8:16);
  let _ = assert_eq(get_data(u16:0x2000 + u16:16), u8:33);
  let _ = assert_eq(get_data(u16:0x2000 + u16:33), u8:67);
  let _ = assert_eq(get_data(u16:0x2000 + u16:67), u8:134);
  let _ = assert_eq(get_data(u16:0x2000 + u16:134), u8:13);
  let _ = assert_eq(get_data(u16:0x2000 + u16:13), u8:27);
  let _ = assert_eq(get_data(u16:0x2000 + u16:27), u8:54);
  let _ = assert_eq(get_data(u16:0x2000 + u16:54), u8:108);
  let _ = assert_eq(get_data(u16:0x2000 + u16:108), u8:216);
  let _ = assert_eq(get_data(u16:0x2000 + u16:216), u8:177);
  let _ = assert_eq(get_data(u16:0x2000 + u16:177), u8:99);
  let _ = assert_eq(get_data(u16:0x2000 + u16:99), u8:199);
  let _ = assert_eq(get_data(u16:0x2000 + u16:199), u8:143);
  let _ = assert_eq(get_data(u16:0x2000 + u16:143), u8:30);
  let _ = assert_eq(get_data(u16:0x2000 + u16:30), u8:60);
  let _ = assert_eq(get_data(u16:0x2000 + u16:60), u8:121);
  let _ = assert_eq(get_data(u16:0x2000 + u16:121), u8:243);
  let _ = assert_eq(get_data(u16:0x2000 + u16:243), u8:231);
  let _ = assert_eq(get_data(u16:0x2000 + u16:231), u8:206);
  let _ = assert_eq(get_data(u16:0x2000 + u16:206), u8:156);
  let _ = assert_eq(get_data(u16:0x2000 + u16:156), u8:57);
  let _ = assert_eq(get_data(u16:0x2000 + u16:57), u8:115);
  let _ = assert_eq(get_data(u16:0x2000 + u16:115), u8:230);
  let _ = assert_eq(get_data(u16:0x2000 + u16:230), u8:204);
  let _ = assert_eq(get_data(u16:0x2000 + u16:204), u8:152);
  let _ = assert_eq(get_data(u16:0x2000 + u16:152), u8:49);
  let _ = assert_eq(get_data(u16:0x2000 + u16:49), u8:98);
  let _ = assert_eq(get_data(u16:0x2000 + u16:98), u8:197);
  let _ = assert_eq(get_data(u16:0x2000 + u16:197), u8:139);
  let _ = assert_eq(get_data(u16:0x2000 + u16:139), u8:22);
  let _ = assert_eq(get_data(u16:0x2000 + u16:22), u8:45);
  let _ = assert_eq(get_data(u16:0x2000 + u16:45), u8:90);
  let _ = assert_eq(get_data(u16:0x2000 + u16:90), u8:180);
  let _ = assert_eq(get_data(u16:0x2000 + u16:180), u8:105);
  let _ = assert_eq(get_data(u16:0x2000 + u16:105), u8:210);
  let _ = assert_eq(get_data(u16:0x2000 + u16:210), u8:164);
  let _ = assert_eq(get_data(u16:0x2000 + u16:164), u8:72);
  let _ = assert_eq(get_data(u16:0x2000 + u16:72), u8:145);
  let _ = assert_eq(get_data(u16:0x2000 + u16:145), u8:34);
  let _ = assert_eq(get_data(u16:0x2000 + u16:34), u8:69);
  let _ = assert_eq(get_data(u16:0x2000 + u16:69), u8:138);
  let _ = assert_eq(get_data(u16:0x2000 + u16:138), u8:20);
  let _ = assert_eq(get_data(u16:0x2000 + u16:20), u8:41);
  let _ = assert_eq(get_data(u16:0x2000 + u16:41), u8:82);
  let _ = assert_eq(get_data(u16:0x2000 + u16:82), u8:165);
  let _ = assert_eq(get_data(u16:0x2000 + u16:165), u8:74);
  let _ = assert_eq(get_data(u16:0x2000 + u16:74), u8:149);
  let _ = assert_eq(get_data(u16:0x2000 + u16:149), u8:42);
  let _ = assert_eq(get_data(u16:0x2000 + u16:42), u8:84);
  let _ = assert_eq(get_data(u16:0x2000 + u16:84), u8:169);
  let _ = assert_eq(get_data(u16:0x2000 + u16:169), u8:83);
  let _ = assert_eq(get_data(u16:0x2000 + u16:83), u8:167);
  let _ = assert_eq(get_data(u16:0x2000 + u16:167), u8:78);
  let _ = assert_eq(get_data(u16:0x2000 + u16:78), u8:157);
  let _ = assert_eq(get_data(u16:0x2000 + u16:157), u8:59);
  let _ = assert_eq(get_data(u16:0x2000 + u16:59), u8:119);
  let _ = assert_eq(get_data(u16:0x2000 + u16:119), u8:238);
  let _ = assert_eq(get_data(u16:0x2000 + u16:238), u8:221);
  let _ = assert_eq(get_data(u16:0x2000 + u16:221), u8:187);
  let _ = assert_eq(get_data(u16:0x2000 + u16:187), u8:118);
  let _ = assert_eq(get_data(u16:0x2000 + u16:118), u8:236);
  let _ = assert_eq(get_data(u16:0x2000 + u16:236), u8:217);
  let _ = assert_eq(get_data(u16:0x2000 + u16:217), u8:179);
  let _ = assert_eq(get_data(u16:0x2000 + u16:179), u8:103);
  let _ = assert_eq(get_data(u16:0x2000 + u16:103), u8:207);
  let _ = assert_eq(get_data(u16:0x2000 + u16:207), u8:158);
  let _ = assert_eq(get_data(u16:0x2000 + u16:158), u8:61);
  let _ = assert_eq(get_data(u16:0x2000 + u16:61), u8:123);
  let _ = assert_eq(get_data(u16:0x2000 + u16:123), u8:247);
  let _ = assert_eq(get_data(u16:0x2000 + u16:247), u8:239);
  let _ = assert_eq(get_data(u16:0x2000 + u16:239), u8:223);
  let _ = assert_eq(get_data(u16:0x2000 + u16:223), u8:191);
  let _ = assert_eq(get_data(u16:0x2000 + u16:191), u8:126);
  let _ = assert_eq(get_data(u16:0x2000 + u16:126), u8:253);
  let _ = assert_eq(get_data(u16:0x2000 + u16:253), u8:250);
  let _ = assert_eq(get_data(u16:0x2000 + u16:250), u8:244);
  let _ = assert_eq(get_data(u16:0x2000 + u16:244), u8:233);
  let _ = assert_eq(get_data(u16:0x2000 + u16:233), u8:211);
  let _ = assert_eq(get_data(u16:0x2000 + u16:211), u8:166);
  let _ = assert_eq(get_data(u16:0x2000 + u16:166), u8:76);
  let _ = assert_eq(get_data(u16:0x2000 + u16:76), u8:153);
  let _ = assert_eq(get_data(u16:0x2000 + u16:153), u8:51);
  let _ = assert_eq(get_data(u16:0x2000 + u16:51), u8:102);
  let _ = assert_eq(get_data(u16:0x2000 + u16:102), u8:205);
  let _ = assert_eq(get_data(u16:0x2000 + u16:205), u8:154);
  let _ = assert_eq(get_data(u16:0x2000 + u16:154), u8:53);
  let _ = assert_eq(get_data(u16:0x2000 + u16:53), u8:106);
  let _ = assert_eq(get_data(u16:0x2000 + u16:106), u8:212);
  let _ = assert_eq(get_data(u16:0x2000 + u16:212), u8:168);
  let _ = assert_eq(get_data(u16:0x2000 + u16:168), u8:81);
  let _ = assert_eq(get_data(u16:0x2000 + u16:81), u8:163);
  let _ = assert_eq(get_data(u16:0x2000 + u16:163), u8:70);
  let _ = assert_eq(get_data(u16:0x2000 + u16:70), u8:140);
  let _ = assert_eq(get_data(u16:0x2000 + u16:140), u8:24);
  let _ = assert_eq(get_data(u16:0x2000 + u16:24), u8:48);
  let _ = assert_eq(get_data(u16:0x2000 + u16:48), u8:96);
  let _ = assert_eq(get_data(u16:0x2000 + u16:96), u8:193);
  let _ = assert_eq(get_data(u16:0x2000 + u16:193), u8:131);
  let _ = assert_eq(get_data(u16:0x2000 + u16:131), u8:7);
  let _ = assert_eq(get_data(u16:0x2000 + u16:7), u8:14);
  let _ = assert_eq(get_data(u16:0x2000 + u16:14), u8:29);
  let _ = assert_eq(get_data(u16:0x2000 + u16:29), u8:58);
  let _ = assert_eq(get_data(u16:0x2000 + u16:58), u8:117);
  let _ = assert_eq(get_data(u16:0x2000 + u16:117), u8:234);
  let _ = assert_eq(get_data(u16:0x2000 + u16:234), u8:213);
  let _ = assert_eq(get_data(u16:0x2000 + u16:213), u8:170);
  let _ = assert_eq(get_data(u16:0x2000 + u16:170), u8:85);
  let _ = assert_eq(get_data(u16:0x2000 + u16:85), u8:171);
  let _ = assert_eq(get_data(u16:0x2000 + u16:171), u8:87);
  let _ = assert_eq(get_data(u16:0x2000 + u16:87), u8:175);
  let _ = assert_eq(get_data(u16:0x2000 + u16:175), u8:95);
  let _ = assert_eq(get_data(u16:0x2000 + u16:95), u8:190);
  let _ = assert_eq(get_data(u16:0x2000 + u16:190), u8:124);
  let _ = assert_eq(get_data(u16:0x2000 + u16:124), u8:249);
  let _ = assert_eq(get_data(u16:0x2000 + u16:249), u8:242);
  let _ = assert_eq(get_data(u16:0x2000 + u16:242), u8:229);
  let _ = assert_eq(get_data(u16:0x2000 + u16:229), u8:202);
  let _ = assert_eq(get_data(u16:0x2000 + u16:202), u8:148);
  let _ = assert_eq(get_data(u16:0x2000 + u16:148), u8:40);
  let _ = assert_eq(get_data(u16:0x2000 + u16:40), u8:80);
  let _ = assert_eq(get_data(u16:0x2000 + u16:80), u8:161);
  let _ = assert_eq(get_data(u16:0x2000 + u16:161), u8:66);
  let _ = assert_eq(get_data(u16:0x2000 + u16:66), u8:132);
  let _ = assert_eq(get_data(u16:0x2000 + u16:132), u8:9);
  let _ = assert_eq(get_data(u16:0x2000 + u16:9), u8:19);
  let _ = assert_eq(get_data(u16:0x2000 + u16:19), u8:39);
  let _ = assert_eq(get_data(u16:0x2000 + u16:39), u8:79);
  let _ = assert_eq(get_data(u16:0x2000 + u16:79), u8:159);
  let _ = assert_eq(get_data(u16:0x2000 + u16:159), u8:63);
  let _ = assert_eq(get_data(u16:0x2000 + u16:63), u8:127);
  let _ = assert_eq(get_data(u16:0x2000 + u16:127), u8:255);
  let _ = assert_eq(get_data(u16:0x2000 + u16:255), u8:254);
  let _ = assert_eq(get_data(u16:0x2000 + u16:254), u8:252);
  let _ = assert_eq(get_data(u16:0x2000 + u16:252), u8:248);
  let _ = assert_eq(get_data(u16:0x2000 + u16:248), u8:240);
  let _ = assert_eq(get_data(u16:0x2000 + u16:240), u8:225);
  let _ = assert_eq(get_data(u16:0x2000 + u16:225), u8:194);
  let _ = assert_eq(get_data(u16:0x2000 + u16:194), u8:133);
  let _ = assert_eq(get_data(u16:0x2000 + u16:133), u8:11);
  let _ = assert_eq(get_data(u16:0x2000 + u16:11), u8:23);
  let _ = assert_eq(get_data(u16:0x2000 + u16:23), u8:47);
  let _ = assert_eq(get_data(u16:0x2000 + u16:47), u8:94);
  let _ = assert_eq(get_data(u16:0x2000 + u16:94), u8:188);
  let _ = assert_eq(get_data(u16:0x2000 + u16:188), u8:120);
  let _ = assert_eq(get_data(u16:0x2000 + u16:120), u8:241);
  let _ = assert_eq(get_data(u16:0x2000 + u16:241), u8:227);
  let _ = assert_eq(get_data(u16:0x2000 + u16:227), u8:198);
  let _ = assert_eq(get_data(u16:0x2000 + u16:198), u8:141);
  let _ = assert_eq(get_data(u16:0x2000 + u16:141), u8:26);
  let _ = assert_eq(get_data(u16:0x2000 + u16:26), u8:52);
  let _ = assert_eq(get_data(u16:0x2000 + u16:52), u8:104);
  let _ = assert_eq(get_data(u16:0x2000 + u16:104), u8:208);
  let _ = assert_eq(get_data(u16:0x2000 + u16:208), u8:160);
  let _ = assert_eq(get_data(u16:0x2000 + u16:160), u8:64);
  let _ = assert_eq(get_data(u16:0x2000 + u16:64), u8:128);
  let _ = assert_eq(get_data(u16:0x2000 + u16:128), u8:1);
}

