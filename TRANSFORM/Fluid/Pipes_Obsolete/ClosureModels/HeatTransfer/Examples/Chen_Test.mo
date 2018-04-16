within TRANSFORM.Fluid.Pipes_Obsolete.ClosureModels.HeatTransfer.Examples;
model Chen_Test "Test case for Chen correlation heat transfer model"
  import TRANSFORM;
  extends TRANSFORM.Icons.Example;
  inner System_TP system(momentumDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));

  TRANSFORM.Fluid.Pipes_Obsolete.StraightPipeOLD pipe(
    use_HeatTransfer=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    isCircular=true,
    length=1,
    nV=10,
    p_b_start=Sink.p,
    use_Ts_start=false,
    h_b_start=Source.h,
    m_flow_a_start=Source.m_flow,
    p_a_start=Sink.p + 1000,
    diameter=1,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.Pipes_Obsolete.ClosureModels.HeatTransfer.TwoPhase.Chen,
    h_a_start=Source.h)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Fluid.Sources.Boundary_ph Sink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    h=2.5e6,
    p=100000)
             annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Fluid.Sources.MassFlowSource_h Source(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=4e5)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Step step[pipe.nV](                          each
      startTime=2, height=3e5*ones(pipe.nV))
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow[pipe.nV]
             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,30})));
equation
  connect(Source.ports[1], pipe.port_a)
    annotation (Line(points={{-40,0},{-10,0}},         color={0,127,255}));
  connect(pipe.port_b, Sink.ports[1])
    annotation (Line(points={{10,0},{40,0}},       color={0,127,255}));

  connect(step.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-19,50},{0,50},{0,40}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, pipe.heatPorts)
    annotation (Line(points={{0,20},{0,4.4},{0.1,4.4}}, color={191,0,0}));
  annotation (experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=1000,
      __Dymola_Algorithm="Esdirk45a"),   __Dymola_experimentSetupOutput,
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})));
end Chen_Test;
