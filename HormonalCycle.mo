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
 // import Modelica.Constants;
  //Real Hp = ((S/T)^n)/(1 + (S/T)^n);
  //Real Hm = 1/(1 + (S/T)^n);
  // ====== P4 =======
  Real P4(start = 0) = 0.688 "ng/mL";
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
  Real LH_pit(start = 3.141e5) "IU";

  //should be rewriten as time functions
//  Real SynLH = (b_LH_syn + k_LH_E2 * Hp_LH.Hp) * Hm_LH.Hm "IU/d";
  Real SynLH = (b_LH_syn + k_LH_E2 * fHp(E2, T_LH_E2, n_LH_E2)) *fHm(P4, T_LH_P4, n_LH_P4);
  Real RelLH = (b_LH_rel + k_LH_GR *  fHp(GR + AgoR,T_LH_GR,n_LH_GR)) * LH_pit;
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
  //  Real SynFSH = k_FSH_Ih * Hm_FSH_syn.Hm / (1 + (Ih_Ae / T_Ih_A) ^ n_Ih_A + (Ih_B / T_Ih_B) ^ n_Ih_B);
  //  Real RelFSH = (b_FSH_rel + k_FSH_GR * Hp_FSH_rel.Hp) * FSH_pit;
/*  Modelica.Blocks.Interfaces.RealInput P4 annotation(
    Placement(visible = true, transformation(origin = {-88, 72}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-88, 72}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u1 annotation(
    Placement(visible = true, transformation(origin = {-92, -16}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-92, -16}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput LH_pit(start = 3.141e5) annotation(
    Placement(visible = true, transformation(origin = {78, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {78, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
*/
equation
  der(LH_pit) = SynLH - RelLH;
//added block B
  der(LH_blood) = RelLH / V_blood - (k_LH_on * R_LH + k_LH_cl) * LH_blood;
  der(R_LH) = k_LH_recy * R_LH_des - k_LH_on * LH_blood * R_LH;
  der(LH_R) = k_LH_on * LH_blood * R_LH - k_LH_des * LH_R;
  der(R_LH_des) = k_LH_des * LH_R - k_LH_recy * R_LH_des;
// added block C
//  der(FSH_pit) = SynFSH - RelFSH;
////der(Ih_A);
////der(Ih_B);
////der(Ih_Ae);
//  der(FSH_blood) = RelFSH / V_blood - (k_FSH_on * R_FSH + k_FSH_cl) * FSH_blood;
//  der(R_FSH) = k_FSH_recy * R_FSH_des - k_FSH_on * FSH_blood * R_FSH;
//  der(FSH_R) = k_FSH_on * FSH_blood * R_FSH - k_FSH_des * FSH_R;
//  der(R_FSH_des) = k_FSH_des * FSH_R - k_FSH_recy * R_FSH_des;
end RoblitzEqs;









    function fHp
      input Real S;
      input Real T;
      input Real n;
      output Real Hp;
    algorithm
      Hp := (S / T) ^ n / (1 + (S / T) ^ n);
    end fHp;

    function fHm
      input Real S;
      input Real T;
      input Real n;
      output Real Hm;
    algorithm
      Hm :=  1 / (1 + (S / T) ^ n);
    end fHm;

    model Blood 
    //  input Real RelLH;
     Modelica.Blocks.Interfaces.RealInput RelLH annotation(
        Placement(visible = true, transformation(origin = {-70, 52}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-70, 52}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
     Modelica.Blocks.Interfaces.RealInput RelFSH annotation(
        Placement(visible = true, transformation(origin = {-70, -46}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-70, -46}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    
    //Add block C for FSH and input RelFSH
    
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
     
     
     // serum FSH
     
     parameter Real k_FSH_on = 3.529 "L/(d*IU)";
        parameter Real k_FSH_cl = 114.25 "1/d";
        parameter Real k_FSH_recy = 61.029 "1/d";
        parameter Real k_FSH_des = 138.3 "1/d";
     
    equation //Equations, describing LH in serum and for its receptor's complex
      der(LH_blood) = RelLH / V_blood - (k_LH_on * R_LH + k_LH_cl) * LH_blood;
      der(R_LH) = k_LH_recy * R_LH_des - k_LH_on * LH_blood * R_LH;
      der(LH_R) = k_LH_on * LH_blood * R_LH - k_LH_des * LH_R;
      der(R_LH_des) = k_LH_des * LH_R - k_LH_recy * R_LH_des;
     
    //Equations, describing FSH in serum and for its receptor's complex
      der(FSH_blood) = RelFSH / V_blood - (k_FSH_on * R_FSH + k_FSH_cl) * FSH_blood;
      der(R_FSH) = k_FSH_recy * R_FSH_des - k_FSH_on * FSH_blood * R_FSH;
      der(FSH_R) = k_FSH_on * FSH_blood * R_FSH - k_FSH_des * FSH_R;
      der(R_FSH_des) = k_FSH_des * FSH_R - k_FSH_recy * R_FSH_des;
      
      
      
    annotation(
        Diagram(graphics = {Rectangle(origin = {3, -4}, fillColor = {255, 24, 3}, fillPattern = FillPattern.VerticalCylinder, extent = {{-59, 84}, {59, -84}})}));
        
        
        
        
    end Blood;














    model GlandPit
      // ====== P4 =======
      Real P4(start = 0) = 0.688 "ng/mL";
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
      Real LH_pit(start = 3.141e5) "IU";
    
    
    
    
      Real SynLH = (b_LH_syn + k_LH_E2 * fHp(E2, T_LH_E2, n_LH_E2)) *fHm(P4, T_LH_P4, n_LH_P4);
      Real RelLH = (b_LH_rel + k_LH_GR *  fHp(GR + AgoR,T_LH_GR,n_LH_GR)) * LH_pit;
    
    //=============
        parameter Real freq = 3.179;
  //make as input
        /*parameter/Not sure about units 1/d /  described by algebraic equation page 29 bio...494.pdf*/
        parameter Real T_FSH_freq = 12.8 "1/d";
        parameter Real n_FSH_freq = 5 "-";
        parameter Real T_FSH_GR = 0.0003 "nmol/L";
        parameter Real n_FSH_GR = 2 "-";
      
        parameter Real k_FSH_Ih = 2.213e+4 "IU/d";
        parameter Real n_IhA = 5 "-";
        parameter Real n_IhB = 2 "-";
        parameter Real T_IhA = 95.81 "IU/mL";
        parameter Real T_IhB = 70 "pg/mL";
        parameter Real b_FSH_rel = 0.057 "1/d";
        parameter Real k_FSH_GR = 0.272 "1/d";
    
        Real IhA(start = 0.637) "IU/mL";
        Real IhAe(start = 52.43) "IU/mL";
        Real IhB(start = 72.17) "pg/mL";
        Real FSH_pit(start = 6.928e+4) "IU";
        Real FSH_blood(start = 6.286) "IU/L";
        Real R_FSH(start = 5.141) "IU/L";
        Real FSH_R(start = 1.030) "IU/L";
        Real R_FSH_des(start = 2.330) "IU/L";
      /*IhAe//define all of thise and within the field of equations_ IhA
         IhB*/
      Real SynFSH = k_FSH_Ih * fHm(freq,T_FSH_freq,n_FSH_freq) / (1 + (IhAe / T_IhA) ^ n_IhA + (IhB / T_IhB) ^ n_IhB);
      Real RelFSH = (b_FSH_rel + k_FSH_GR * fHp((GR + AgoR), T_FSH_GR,n_FSH_GR)) * FSH_pit;
    
    //=============
    equation
//LH Pitatory gland
      der(LH_pit) = SynLH - RelLH;
//FSH Pitatory gland
      der(FSH_pit) = SynFSH - RelFSH;
      der(IhA);
      der(IhB);
      der(IhAe);
    
    
    end GlandPit;


    model Ovaries
    //parameters
    //development of follicle and corpus luteum
    parameter Real k_s=0.219 "1/d";    //EQ11
    parameter Real T_s_FSH=3 "IU/L";
    parameter Real n_s_FSH=5 "-";
    parameter Real k_s_cl=1.343 "1/d";
    parameter Real T_s_P4=1.235 "ng/mL";
    parameter Real n_s_P4=5 "-";
    parameter Real k_AF1=3.662 "[PrA1/d]"; //EQ12
    parameter Real T_AF1_FSH_R=0.608 "IU/L";
    parameter Real n_AF1_FSH_R=5 "-";
    parameter Real k_AF2_AF1=1.221 "L/(d*IU)";
    parameter Real k_AF3_AF2=4.882 "1/d"; //eq13
    parameter Real SF_LH_R=2.726 "IU/L";
    parameter Real n_AF3_AF2=3.689 "-";
    parameter Real k_AF3_AF3=0.122 "L/(d*IU)";//eq14
    parameter Real SeFmax=10 "[SeF1]";
    parameter Real k_AF4_AF3=122.06 "1/d";
    parameter Real n_AF4_AF3=5"-";//eq15
    parameter Real k_AF4_AF4=12.206"1/d";
    parameter Real n_AF4=2"-";
    parameter Real k_PrF_AF4=332.75"1/d";
    parameter Real k_PrF_cl=122.06 "1/d";
    parameter Real n_OvF=6"-";
    parameter Real k_OvF=7.984"1/d";
    parameter Real T_OvF_PrF=3"[PrF]";
    parameter Real n_OvF_PrF=10"-";
    parameter Real k_OvF_cl=12.206"1/d";
    parameter Real k_Sc1=1.208"1/d";//eq18
    parameter Real T_Sc1_OvF=0.02"[OvF]";
    parameter Real n_Sc1_OvF=10"-";
    parameter Real k_Sc2_Sc1=1.221"1/d";
    parameter Real k_Lut1_Sc2=0.958"1/d";//eq19
    parameter Real k_Lut2_Lut1=0.925"1/d";//eq20
    parameter Real m_Lut_GR=20"-";
    parameter Real T_Lut_GR=0.0008"nmol/L";
    parameter Real n_Lut_GR=5"-";
    parameter Real k_Lut3_Lut2=0.7567"1/d";
    parameter Real k_Lut4_Lut3=0.610"1/d";
    parameter Real k_Lut4_cl=0.543"1/d";
    //=====E2,P4 and inhibins
    parameter Real b_E2=51.558"pg/(mL*d)";//eq24
    parameter Real k_E2_AF2=2.0945"pg/(mL*d*[AF2])";
    parameter Real k_E2_AF3=9.28"pg/(mL*d*[AF3]*[LH])";
    parameter Real k_E2_AF4=6960.53"pg/(mL*d*[AF4])";
    parameter Real k_E2_PrF=0.972"pg/(mL*d*[PrF]*[LH])";
    parameter Real k_E2_Lut1=1713.71"pg/(mL*d*[Lut1])";
    parameter Real k_E2_Lut4=8675.14"pg/(mL*d*[Lut4])";
    parameter Real k_E2_cl=5.235"1/d";
    parameter Real b_P4=0.934"ng/(mL*d)";//eq25
    parameter Real k_P4_Lut4=761.64"ng/(mL*d*[Lut4])";
    parameter Real k_P4_cl=5.13"1/d";
    
    parameter Real b_IhA=1.445"IU/(mL*d)"; //eq26
    parameter Real k_IhA_PrF=2.285"IU/(mL*d*[PrF])";
    parameter Real k_IhA_Sc1=60"pg/(mL*d*[Sc1])";
    parameter Real k_IhA_Lut1=180 "pg/(mL*d*[Lut1])";
    parameter Real k_IhA_Lut2=28.211"IU/(mL*d*[Lut2])";
    parameter Real k_IhA_Lut3=216.85"IU/(mL*d*[Lut3])";
    parameter Real k_IhA_Lut4=114.25"IU/(mL*d*[Lut4])";
    parameter Real k_IhA=4.287"1/d";
    
    parameter Real b_IhB=89.493"pg/(mL*d)";//eq27
    parameter Real k_IhB_AF2=447.47"pg/(mL*d*[AF2])";
    parameter Real k_IhB_Sc2=134240.2"pg/(mL*d*[AF3])";
    parameter Real k_IhB_cl=172.45"1/d";
    
    parameter Real k_IhAe_cl=0.199"1/d";
    
    //functions 
    Real s(start=0.417)"-";//EQ11
    input Real FSH_blood;//INPUT
    //input Real P4;//INPUT//comment if I keep E2,P4 defined here
    Real AF1(start=2.811)"[Foll]";//EQ12
    input Real FSH_R;//INPUT
    Real AF2(start=27.64) "[Foll]";//eq13
    input Real LH_R;//Input
    Real AF3(start=0.801) "[Foll]";//eq14
    Real AF4(start=6.345e-5) "[Foll]";//eq15
    Real PrF(start=0.336)"[Foll]";//eq16
    Real OvF(start=1.313e-16)"[Foll]";//eq17
    Real Sc1(start=1.433e-10)"[Foll]";//eq18
    Real Sc2(start=7.278e-8)"[Foll]";//eq19
    Real Lut1(start=1.293e-6)"[Foll]";//eq20
    input Real GR_a;
    Real Lut2(start=3.093e-5)"[Foll]";//eq21
    Real Lut3(start=4.853e-4)"[Foll]";//eq22
    Real Lut4(start=3.103e-3)"[Foll]";//eq23
    //=====E2,P4 and inhibins
    
    
    input Real LH_blood;//eq24
    Real E2(start=30.94)"pg/mL";
    Real P4(start=0.688)"ng/mL";//eq25
    Real IhA(start=0.637)"IU/mL";//eq26
    Real IhB(start=72.17)"pg/mL";//eq27
    Real IhAe(start=52.43)"IU/mL";//eq28
    
    equation
    //eq11
    der(s)=k_s*fHp(FSH_blood,T_s_FSH,n_s_FSH)-k_s_cl*fHp(P4,T_s_P4,n_s_P4)*s; 
    //eq12
    der(AF1)= k_AF1*fHp(FSH_R,T_AF1_FSH_R,n_AF1_FSH_R)-k_AF2_AF1*FSH_R*AF1; 
    //eq13
    der(AF2)=k_AF2_AF1*FSH_R*AF1-k_AF3_AF2*((LH_R/SF_LH_R)^(n_AF3_AF2))*s*AF2;
    //eq14
    der(AF3)=k_AF3_AF2*((LH_R/SF_LH_R)^(n_AF3_AF2))*s*AF2+
    k_AF3_AF3*FSH_R*AF3*(1-AF3/SeFmax)-k_AF4_AF3*((LH_R/SF_LH_R)^(n_AF4_AF3))*s*AF3;
    //eq15
    der(AF4)=k_AF4_AF3*((LH_R/SF_LH_R)^(n_AF4_AF3))*s*AF3+k_AF4_AF4*((LH_R/SF_LH_R)^(n_AF4))*AF4*(1-AF4/SeFmax)-k_PrF_AF4*(LH_R/SF_LH_R)*s*AF4;
    //eq16
    der(PrF)=k_PrF_AF4*(LH_R/SF_LH_R)*s*AF4-k_PrF_cl*((LH_R/SF_LH_R)^(n_OvF))*s*PrF;
    //eq17
    der(OvF)=k_OvF*((LH_R/SF_LH_R)^(n_OvF))*s*fHp(PrF,T_OvF_PrF,n_OvF_PrF)-k_OvF_cl*OvF;
    //eq18
    der(Sc1)=k_Sc1*fHp(OvF,T_Sc1_OvF,n_Sc1_OvF)-k_Sc2_Sc1*Sc1;
    //eq19
    der(Sc2)=k_Sc2_Sc1*Sc1-k_Lut1_Sc2*Sc2;
    //eq20
    der(Lut1)=k_Lut1_Sc2*Sc2-k_Lut2_Lut1*(1+m_Lut_GR*fHp(GR_a,T_Lut_GR,n_Lut_GR))*Lut1;
    //eq21
    der(Lut2)=k_Lut2_Lut1*(1+m_Lut_GR*fHp(GR_a,T_Lut_GR,n_Lut_GR))*Lut1-k_Lut3_Lut2*(1+m_Lut_GR*fHp(GR_a,T_Lut_GR,n_Lut_GR))*Lut2;
    //eq22
    der(Lut3)=k_Lut3_Lut2*(1+m_Lut_GR*fHp(GR_a,T_Lut_GR,n_Lut_GR))*Lut2-k_Lut4_Lut3*(1+m_Lut_GR*fHp(GR_a,T_Lut_GR,n_Lut_GR))*Lut3;
    //eq23
    der(Lut4)=k_Lut4_Lut3*(1+m_Lut_GR*fHp(GR_a,T_Lut_GR,n_Lut_GR))*Lut3-k_Lut4_cl*(1+m_Lut_GR*fHp(GR_a,T_Lut_GR,n_Lut_GR))*Lut4;
    
    //E2,P4 and inhibins 
    //eq24
    der(E2)=b_E2+k_E2_AF2*AF2+k_E2_AF3*LH_blood*AF3+k_E2_AF4*AF4+
    k_E2_PrF*LH_blood*PrF+k_E2_Lut1*Lut1+k_E2_Lut4*Lut4-k_E2_cl*E2;
    //eq25
    der(P4)=b_P4+k_P4_Lut4*Lut4-k_P4_cl*P4;
    //eq26
    der(IhA)=b_IhA+k_IhA_PrF*PrF+k_IhA_Sc1*Sc1+k_IhA_Lut1*Lut1+k_IhA_Lut2*Lut2+k_IhA_Lut3*Lut3+k_IhA_Lut4*Lut4-k_IhA*IhA;
    //eq27
    der(IhB)=b_IhB+k_IhB_AF2*AF2+k_IhB_Sc2*Sc2-k_IhB_cl*IhB;
    
    //eq28
    der(IhAe)=k_IhA*IhA-k_IhAe_cl*IhAe;
    
    
    end Ovaries;



























    
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
