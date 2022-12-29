module user_module(
  input wire [23:0] io_in,
  output wire [7:0] out
);
  wire eq_1618;
  wire eq_1619;
  wire eq_1622;
  wire eq_1623;
  wire eq_1624;
  wire or_1625;
  wire eq_1626;
  wire eq_1627;
  wire eq_1628;
  wire eq_1629;
  wire eq_1631;
  wire or_1638;
  wire or_1640;
  wire or_1644;
  wire or_1645;
  wire eq_1646;
  wire eq_1647;
  wire or_1648;
  wire or_1651;
  wire or_1652;
  wire [7:0] result;
  assign eq_1618 = io_in[18:3] == 16'h0006;
  assign eq_1619 = io_in[18:3] == 16'h0010;
  assign eq_1622 = io_in[18:3] == 16'h0003;
  assign eq_1623 = io_in[18:3] == 16'h0005;
  assign eq_1624 = io_in[18:3] == 16'h0011;
  assign or_1625 = io_in[18:3] == 16'h0000 | io_in[18:3] == 16'h000e;
  assign eq_1626 = io_in[18:3] == 16'h0002;
  assign eq_1627 = io_in[18:3] == 16'h0004;
  assign eq_1628 = io_in[18:3] == 16'h0008;
  assign eq_1629 = io_in[18:3] == 16'h000b;
  assign eq_1631 = io_in[18:3] == 16'h0014;
  assign or_1638 = eq_1618 | eq_1619 | io_in[18:3] == 16'h0013;
  assign or_1640 = eq_1622 | eq_1623 | eq_1624;
  assign or_1644 = or_1625 | eq_1626 | eq_1627 | eq_1628 | eq_1629 | io_in[18:3] == 16'h000d | eq_1619 | eq_1631;
  assign or_1645 = io_in[18:3] == 16'h0001 | io_in[18:3] == 16'h0009;
  assign eq_1646 = io_in[18:3] == 16'h000a;
  assign eq_1647 = io_in[18:3] == 16'h000f;
  assign or_1648 = eq_1618 | eq_1619;
  assign or_1651 = or_1638 | eq_1629;
  assign or_1652 = eq_1626 | io_in[18:3] == 16'h000c | or_1640;
  assign result = io_in[18:3] > 16'h2000 & io_in[18:3] < 16'h2100 ? {io_in[9:3], io_in[6] ^ io_in[7] ^ io_in[8] ^ io_in[10]} : {or_1644, or_1644 | or_1645 | eq_1622 | eq_1623 | eq_1646 | eq_1647, or_1625 | or_1648 | eq_1628 | io_in[18:3] == 16'h0012 | eq_1646 | eq_1629 | eq_1624 | eq_1631, or_1625 | eq_1622 | or_1648 | eq_1646 | eq_1631, eq_1626 | eq_1627 | io_in[18:3] == 16'h0007 | eq_1646 | or_1638 | eq_1624 | eq_1631, or_1640 | or_1651 | eq_1647, or_1652 | or_1651 | eq_1631 | io_in[18:3] == 16'h0015, or_1645 | or_1652};
  assign out = result;
endmodule
