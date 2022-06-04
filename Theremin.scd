
s.killAll;
s.boot;
(
SynthDef(\theremin, {
	arg atk=0.01,rel=0.1,crv= -3;
	var freq, synth, vol, amp,env;
	freq = \freq.kr(440,1.1);
	amp = \amp.kr(0,1.1);
	env = EnvGen.ar(Env.asr(atk,1,rel,crv),1);
	synth = SinOsc.ar(freq);
	Out.ar(0,synth*env*amp);
}).add;
)
(
OSCdef(\ciao,{
	arg msg;
	~synth.set(\freq, msg[1].asFloat);
	~synth.set(\amp, msg[2].asFloat);
},"/ciao");
)

n = NetAddr("127.0.0.1",57120);

~synth=Synth(\theremin);
