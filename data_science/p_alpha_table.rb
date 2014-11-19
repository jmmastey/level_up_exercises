module PAlphaTable
  INFINITY = Float::INFINITY
  P_ALPHA_TABLE = { 1 => {  0.0 => (0...0.455),
                            0.5 => (0.455...2.706),
                            0.10 => (2.706...3.841),
                            0.05 => (3.841...5.412),
                            0.02 => (5.412...6.635),
                            0.01 => (6.635...10.827),
                            0.001 => (10.827...INFINITY) },
                    2 => {  0.5  => (1.386...4.605),
                            0.10 => (4.605...5.991),
                            0.05 => (5.991...7.824),
                            0.02 => (7.824...9.210),
                            0.01 => (9.210...13.815),
                            0.001 => (13.815...INFINITY) },
                    3 => {  0.5 => (2.366...6.251),
                            0.10 => (6.251...7.815),
                            0.05 => (7.815...9.837),
                            0.02 => (9.837...11.345),
                            0.01 => (11.345...16.268),
                            0.001 => (16.268...INFINITY) },
                    4 => {  0.5 => (3.357...7.779),
                            0.10 => (7.779...9.488),
                            0.05 => (9.488...11.668),
                            0.02 => (11.668...13.227),
                            0.01 => (13.227...18.465),
                            0.001 => (18.465...INFINITY) },
                    5 => {  0.5  => (4.351...9.236),
                            0.10 => (9.236...11.070),
                            0.05 => (11.070...13.388),
                            0.02 => (13.388...15.086),
                            0.01 => (15.086...20.517),
                            0.001 => (20.517...INFINITY) } }

  def self.significance_level(df, chi_square)
    fail 'invalid degrees of freedom' unless P_ALPHA_TABLE.include?(df)
    p_values = P_ALPHA_TABLE[df]
    p_values.find { |(_, range)| range.include? chi_square }.first
  end
end
