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
  //Real Hp = ((S/T)^n)/(1 + (S/T)^n);
  //Real Hm = 1/(1 + (S/T)^n);
  
  // ====== P4 =======
  Real P4 (start = 0)= 0.688 "ng/mL";
  parameter Real T_LH_P4(unit= "ng/mL") = 2.371 "ng/mL";
  parameter Real n_LH_P4 = 1 "-";
  
  // ====== E2 =======
  Real E2 = 30.94 "pg/mL";
  parameter Real T_LH_E2 = 132.2 "pg/mL";
  parameter Real n_LH_E2 = 10 "-";
  
  // ====== GR =======
  parameter Real k_LH_GR=0.1904 "1/d";
  parameter Real T_LH_GR=0.0003 "nmol/L ";
  parameter Real n_LH_GR=5 "-";
  Real GR=8.618e-5 "nmol/L - active?";
  
  
  // ===== AGO-R ====
  Real AgoR=0;
  
  // ====== LH =======
  parameter Real b_LH_syn = 7309.92 "IU/d";
  parameter Real k_LH_E2 = 7309.92 "IU/d";
  parameter Real b_LH_rel=0.00476 "1/d";
  Real LH_pit(start=3.141e5) "IU";
  
  Hp Hp_LH(S = E2, T = T_LH_E2, n = n_LH_E2);
  Hm Hm_LH(S = P4, T = T_LH_P4, n = n_LH_P4);
  Hp Hp_LH_rel(S = GR + AgoR, T = T_LH_GR, n = n_LH_GR);
  Real SynLH = (b_LH_syn + k_LH_E2*Hp_LH.Hp)*Hm_LH.Hm "IU/d";
  Real RelLH=(b_LH_rel+k_LH_GR*Hp_LH_rel.Hp)*LH_pit;
  
  equation
  
  der(LH_pit)=SynLH-RelLH;
  
  end RoblitzEqs;











  model Hp
  input Real S;
  input Real T;
  input Real n;
  Real Hp = ((S/T)^n)/(1 + (S/T)^n);
  end Hp;

  model Hm
    input Real S;
    input Real T;
    input Real n;
    Real Hm = 1 / (1 + (S / T) ^ n);
  end Hm;


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
        Icon(graphics = {Rectangle(origin = {-31, 26}, extent = {{-45, 48}, {45, -48}})}));end test;

    package Components
    model Hp
    input Real S;
    input Real T;
    input Real n;
    Real Hp = ((S/T)^n)/(1 + (S/T)^n);
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
      parameter Real k_LH_GR=0.1904 "1/d";
      parameter Real T_LH_GR=0.0003 "nmol/L ";
      parameter Real n_LH_GR=5 "-";
      Real GR=8.618e-5 "nmol/L - active?";
      
      
      // ===== AGO-R ====
      /*Real AgoR=0;*/
      
      // ====== LH =======
      parameter Real b_LH_syn = 7309.92 "IU/d";
      parameter Real k_LH_E2 = 7309.92 "IU/d";
      parameter Real b_LH_rel=0.00476 "1/d";
      Real LH_pit(start=3.141e5) "IU";
      
      Hp Hp_LH_rel(S = GR + AgoR, T = T_LH_GR, n = n_LH_GR);
      //Real RelLHc=(b_LH_rel+k_LH_GR*Hp_LH_rel.Hp);//*LH_pit;
  Modelica.Blocks.Interfaces.RealInput GR_I annotation(
          Placement(visible = true, transformation(origin = {-90, 48}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, 48}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput AgoR annotation(
          Placement(visible = true, transformation(origin = {-82, -54}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-82, -54}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput RelClearance  =(b_LH_rel+k_LH_GR*Hp_LH_rel.Hp) annotation(
          Placement(visible = true, transformation(origin = {66, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {66, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      
      
      equation
      GR = GR_I;
      end Rel_LH_pit;


    end Components;

  end Visual;
  annotation(
    uses(Physiolibrary(version = "2.3.2-beta"), Modelica(version = "3.2.2")));
end HormonalCycle;
