package HormonalCycle
  model test
    Physiolibrary.Chemical.Components.Substance substance1 annotation(
      Placement(visible = true, transformation(origin = {-32, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Physiolibrary.Chemical.Components.Substance substance2 annotation(
      Placement(visible = true, transformation(origin = {66, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Physiolibrary.Chemical.Sources.UnlimitedSolutePump unlimitedSolutePump1 annotation(
      Placement(visible = true, transformation(origin = {-86, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(substance1.internalHeat, unlimitedSolutePump1.q_out) annotation(
      Line(points = {{-20, -40}, {-76, -40}}, color = {0, 0, 127}));
  end test;

  package EquationBased
    model RoblitzEqs
    import Modelica.Constants;
      //Real Hp = ((S/T)^n)/(1 + (S/T)^n);
      //Real Hm = 1/(1 + (S/T)^n);
      // ====== P4 =======
     // Real P4(start = 0) = 0.688 "ng/mL";
      parameter Real T_LH_P4(unit = "ng/mL") = 2.371 "ng/mL";
      parameter Real n_LH_P4 = 1 "-";
      // ====== E2 =======
      Real E2 = 30.94 "pg/mL";
      parameter Real T_LH_E2 = 132.2 "pg/mL";
      parameter Real n_LH_E2 = 10 "-";
      // ====== GR =======
      parameter Real k_LH_GR = 0.1904 "1/d";
      parameter Real T_LH_GR = 0.0003 "nmol/L ";
      parameter Real n_LH_GR = 5 "-";
      Real GR = 8.618e-5 "nmol/L - active?";
      // ===== AGO-R ====
      Real AgoR = 0;
      // ====== LH =======
      //pituitary LH
      parameter Real b_LH_syn = 7309.92 "IU/d";
      parameter Real k_LH_E2 = 7309.92 "IU/d";
      parameter Real b_LH_rel = 0.00476 "1/d";
    //  Real LH_pit(start = 3.141e5) "IU";
      Hp Hp_LH(S = E2, T = T_LH_E2, n = n_LH_E2);
      //syn
      Hm Hm_LH(S = P4, T = T_LH_P4, n = n_LH_P4);
      //syn
      Hp Hp_LH_rel(S = GR + AgoR, T = T_LH_GR, n = n_LH_GR);
      //should be rewriten as time functions
      Real SynLH = (b_LH_syn + k_LH_E2 * Hp_LH.Hp) * Hm_LH.Hm "IU/d";
      Real SynLH2 = (b_LH_syn + k_LH_E2 * fHp(E2, T_LH_E2, n_LH_E2)) * Hm_LH.Hm * pi "IU/d";
      Real RelLH = (b_LH_rel + k_LH_GR * Hp_LH_rel.Hp) * LH_pit;
      //serum LH blood Block B
      parameter Real V_blood = 6.589 "L";
      parameter Real k_LH_on = 2.143 "L/(d*IU)";
      parameter Real k_LH_cl = 74.851 "1/d";
      Real LH_blood(start = 3.487) "IU/L";
      parameter Real k_LH_recy = 68.949 "1/d";
      parameter Real k_LH_des = 183.36 "1/d";
      Real R_LH(start = 8.157) "IU/L";
      Real LH_R(start = 0.332) "IU/L";
      Real R_LH_des(start = 0.882) "IU/L";
  //  // ====== FSH ======
      //  parameter Real freq = 3.179;
      //  /*parameter/Not sure about units 1/d /  described by algebraic equation page 29 bio...494.pdf*/
      //  parameter Real T_FSH_freq = 12.8 "1/d";
      //  parameter Real n_FSH_freq = 5 "-";
      //  parameter Real T_FSH_GR = 0.0003 "nmol/L";
      //  parameter Real n_FSH_GR = 2 "-";
      //  Hm Hm_FSH_syn(S = freq, T = T_FSH_freq, n = n_FSH_freq);
      //  Hp Hp_FSH_rel(S = GR + AgoR, T = T_FSH_GR, n = n_FSH_GR);
      //  parameter Real k_FSH_Ih = 2.213e+4 "IU/d";
      //  parameter Real n_Ih_A = 5 "-";
      //  parameter Real n_Ih_B = 2 "-";
      //  parameter Real T_Ih_A = 95.81 "IU/mL";
      //  parameter Real T_Ih_B = 70 "pg/mL";
      //  parameter Real b_FSH_rel = 0.057 "1/d";
      //  parameter Real k_FSH_GR = 0.272 "1/d";
      //  parameter Real k_FSH_on = 3.529 "L/(d*IU)";
      //  parameter Real k_FSH_cl = 114.25 "1/d";
      //  parameter Real k_FSH_recy = 61.029 "1/d";
      //  parameter Real k_FSH_des = 138.3 "1/d";
      //  Real Ih_A(start = 0.637) "IU/mL";
      //  Real Ih_Ae(start = 52.43) "IU/mL";
      //  Real Ih_B(start = 72.17) "pg/mL";
      //  Real FSH_pit(start = 6.928e+4) "IU";
      //  Real FSH_blood(start = 6.286) "IU/L";
      //  Real R_FSH(start = 5.141) "IU/L";
      //  Real FSH_R(start = 1.030) "IU/L";
      //  Real R_FSH_des(start = 2.330) "IU/L";
      //  /*Ih_Ae//define all of thise and within the field of equations_ IhA
      //    Ih_B*/
      //  Real Syn_FSH = k_FSH_Ih * Hm_FSH_syn.Hm / (1 + (Ih_Ae / T_Ih_A) ^ n_Ih_A + (Ih_B / T_Ih_B) ^ n_Ih_B);
      //  Real Rel_FSH = (b_FSH_rel + k_FSH_GR * Hp_FSH_rel.Hp) * FSH_pit;
      Modelica.Blocks.Interfaces.RealInput P4 annotation(
        Placement(visible = true, transformation(origin = {-88, 72}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-88, 72}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u1 annotation(
        Placement(visible = true, transformation(origin = {-92, -16}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-92, -16}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput LH_pit(start = 3.141e5) annotation(
        Placement(visible = true, transformation(origin = {78, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {78, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      der(LH_pit) = SynLH - RelLH;
//added block B
      der(LH_blood) = RelLH / V_blood - (k_LH_on * R_LH + k_LH_cl) * LH_blood;
      der(R_LH) = k_LH_recy * R_LH_des - k_LH_on * LH_blood * R_LH;
      der(LH_R) = k_LH_on * LH_blood * R_LH - k_LH_des * LH_R;
      der(R_LH_des) = k_LH_des * LH_R - k_LH_recy * R_LH_des;
// added block C
    //  der(FSH_pit) = Syn_FSH - Rel_FSH;
////der(Ih_A);
////der(Ih_B);
////der(Ih_Ae);
    //  der(FSH_blood) = Rel_FSH / V_blood - (k_FSH_on * R_FSH + k_FSH_cl) * FSH_blood;
    //  der(R_FSH) = k_FSH_recy * R_FSH_des - k_FSH_on * FSH_blood * R_FSH;
    //  der(FSH_R) = k_FSH_on * FSH_blood * R_FSH - k_FSH_des * FSH_R;
    //  der(R_FSH_des) = k_FSH_des * FSH_R - k_FSH_recy * R_FSH_des;
    end RoblitzEqs;







    model Hp
      input Real S;
      input Real T;
      input Real n;
      Real Hp = (S / T) ^ n / (1 + (S / T) ^ n);
    end Hp;

    model Hm
      input Real S;
      input Real T;
      input Real n;
      Real Hm = 1 / (1 + (S / T) ^ n);
    end Hm;

    function fHp
      input Real S;
      input Real T;
      input Real n;
      output Real Hp ;
      algorithm
      Hp := (S / T) ^ n / (1 + (S / T) ^ n);
    end fHp;



  end EquationBased;

  package Visual
    model test
      Physiolibrary.Chemical.Components.Substance substance1 annotation(
        Placement(visible = true, transformation(origin = {-26, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Physiolibrary.Chemical.Sources.UnlimitedSolutePumpOut unlimitedSolutePumpOut1 annotation(
        Placement(visible = true, transformation(origin = {-86, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Physiolibrary.Chemical.Components.Clearance clearance1 annotation(
        Placement(visible = true, transformation(origin = {52, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Rel_LH_pit rel_LH_pit1 annotation(
        Placement(visible = true, transformation(origin = {38, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Physiolibrary.Chemical.Sensors.ConcentrationMeasure concentrationMeasure1 annotation(
        Placement(visible = true, transformation(origin = {-54, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Physiolibrary.Types.RealIO.ConcentrationOutput concentration annotation(
        Placement(visible = true, transformation(origin = {90, -70}, extent = {{-30, -30}, {30, 30}}, rotation = 0), iconTransformation(origin = {90, -70}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    equation
      connect(concentrationMeasure1.concentration, concentration) annotation(
        Line(points = {{-54, -76}, {70, -76}, {70, -70}, {90, -70}}, color = {0, 0, 127}));
      connect(concentrationMeasure1.q_in, substance1.q_out) annotation(
        Line(points = {{-54, -68}, {-26, -68}, {-26, -12}, {-26, -12}}, color = {107, 45, 134}));
      connect(substance1.q_out, unlimitedSolutePumpOut1.q_in) annotation(
        Line(points = {{-26, -12}, {-96, -12}, {-96, -14}, {-96, -14}}, color = {107, 45, 134}));
      connect(clearance1.q_in, substance1.q_out) annotation(
        Line(points = {{42, -10}, {-26, -10}, {-26, -12}, {-26, -12}}, color = {107, 45, 134}));
      connect(rel_LH_pit1.RelClearance, clearance1.solutionFlow) annotation(
        Line(points = {{44, 52}, {54, 52}, {54, -2}, {52, -2}}, color = {0, 0, 127}));
      annotation(
        Icon(graphics = {Rectangle(origin = {-31, 26}, extent = {{-45, 48}, {45, -48}})}));
    end test;

    package Components
      model Hp
        input Real S;
        input Real T;
        input Real n;
        Real Hp = (S / T) ^ n / (1 + (S / T) ^ n);
      end Hp;

      model Hm
        input Real S;
        input Real T;
        input Real n;
        Real Hm = 1 / (1 + (S / T) ^ n);
      end Hm;

      model Rel_LH_pit
        //Real Hp = ((S/T)^n)/(1 + (S/T)^n);
        //Real Hm = 1/(1 + (S/T)^n);
        // ====== GR =======
        parameter Real k_LH_GR = 0.1904 "1/d";
        parameter Real T_LH_GR = 0.0003 "nmol/L ";
        parameter Real n_LH_GR = 5 "-";
        Real GR = 8.618e-5 "nmol/L - active?";
        // ===== AGO-R ====
        /*Real AgoR=0;*/
        // ====== LH =======
        parameter Real b_LH_syn = 7309.92 "IU/d";
        parameter Real k_LH_E2 = 7309.92 "IU/d";
        parameter Real b_LH_rel = 0.00476 "1/d";
        Real LH_pit(start = 3.141e5) "IU";
        Hp Hp_LH_rel(S = GR + AgoR, T = T_LH_GR, n = n_LH_GR);
        //Real RelLHc=(b_LH_rel+k_LH_GR*Hp_LH_rel.Hp);//*LH_pit;
        Modelica.Blocks.Interfaces.RealInput GR_I annotation(
          Placement(visible = true, transformation(origin = {-90, 48}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, 48}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput AgoR annotation(
          Placement(visible = true, transformation(origin = {-82, -54}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-82, -54}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealOutput RelClearance = b_LH_rel + k_LH_GR * Hp_LH_rel.Hp annotation(
          Placement(visible = true, transformation(origin = {66, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {66, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        GR = GR_I;
      end Rel_LH_pit;
    end Components;
  end Visual;
  annotation(
    uses(Physiolibrary(version = "2.3.2-beta"), Modelica(version = "3.2.2")));
end HormonalCycle;
