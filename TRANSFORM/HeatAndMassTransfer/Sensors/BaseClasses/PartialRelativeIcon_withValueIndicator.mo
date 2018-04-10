within TRANSFORM.HeatAndMassTransfer.Sensors.BaseClasses;
partial model PartialRelativeIcon_withValueIndicator

  extends TRANSFORM.Icons.TranslationalSensor;

  parameter Integer precision(min=0) = 0 "Number of decimals displayed";

  replaceable function iconUnit =
      TRANSFORM.Units.Conversions.Functions.BaseClasses.PartialConversion
    "Unit for icon display" annotation (choicesAllMatching=true);

  input Real var "Variable to be converted" annotation(Dialog(group="Input Variables"));

  Real y = iconUnit(var) "Icon display";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{-60,-50},{60,-22}}, textString=DynamicSelect("0.0", String(
               y, format="1." + String(precision) + "f")))}), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialRelativeIcon_withValueIndicator;
