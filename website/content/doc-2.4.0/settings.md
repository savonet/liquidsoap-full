
# Liquidsoap configuration

## Metadata settings

### Metadata map settings

#### Default value for the `insert_missing` parameter.

```liquidsoap
settings.metadata.map.insert_missing := false
```

#### Default value for the `strip` parameter.

```liquidsoap
settings.metadata.map.strip := true
```

## ALSA configuration

### Alsa internal buffer size

This setting is only used in buffered alsa I/O, and affects latency.Set to 0 to disable this setting and use ALSA's default.

```liquidsoap
settings.alsa.alsa_buffer := 0
```

### Number of periods

Set to 0 to disable this setting and use ALSA's default.

```liquidsoap
settings.alsa.periods := 0
```

## Audio settings

Options related to audio.

### Conversion settings

Options related to audio conversion.

#### Channel layout conversion settings

Options related to channel layout conversion.

##### Preferred samplerate converters

Preferred channel layout converter. The native converter is always available.

```liquidsoap
settings.audio.converter.channel_layout.converters := ["native"]
```

#### Samplerate conversion settings

Options related to samplerate conversion.

##### Preferred samplerate converters

Preferred samplerate converter. The native converter is always available.

```liquidsoap
settings.audio.converter.samplerate.converters := ["libsamplerate", "ffmpeg", "native"]
```

##### Libsamplerate conversion settings

Options related to libsamplerate conversion.

###### Resampling quality

Resampling quality, one of: `"best"`, `"medium"`, `"fast"`, `"zero_order"` or `"linear"`. Refer to ocaml-samplerate for details.

```liquidsoap
settings.audio.converter.samplerate.libsamplerate.quality := "fast"
```

##### Native samplerate conversion settings

Options related to native samplerate conversion.

###### Resampling quality

Resampling quality: either "nearest" or "linear".

```liquidsoap
settings.audio.converter.samplerate.native.quality := "linear"
```

## Settings related to charset conversion.

### List of encodings to try for automatic encoding detection.

```liquidsoap
settings.charset.encodings := ["UTF-8", "ISO-8859-1", "UTF-16"]
```

### Do not recode strings over that length.

```liquidsoap
settings.charset.max_string_length := 1024
```

### Directory where charset files are to be found.

```liquidsoap
settings.charset.path := "/usr/share/liquidsoap/camomile"
```

## Clock settings

### How much time ahead (in seconds) we should be until we let the streaming loop rest.

Once we have computed the given amount of time time in advance,we wait until re-starting the streaming loop.

```liquidsoap
settings.clock.latency := 0.1
```

### Number of sources at which a leak warning should be issued.

```liquidsoap
settings.clock.leak_warning := 50
```

### How often (in seconds) we should notify latency issues.

```liquidsoap
settings.clock.log_delay := 1.0
```

### Notify latency issues after delay exceeds this threshold.

```liquidsoap
settings.clock.log_delay_threshold := 0.2
```

### Maximum latency in seconds

If the latency gets higher than this value, the outputs will be reset,instead of trying to catch it up second by second.The reset is typically only useful to reconnect icecast mounts.

```liquidsoap
settings.clock.max_latency := 60.0
```

### Preferred clock implementation. One if: "posix" or "ocaml".

```liquidsoap
settings.clock.preferred := "posix"
```

## Console configuration

### Use color in console output when available. One of: "always", "never" or "auto".

```liquidsoap
settings.console.colorize := "auto"
```

## Crossfade settings

### Assume autocue when all 4 cue in/out and fade in/out metadata override are present.

```liquidsoap
settings.crossfade.assume_autocue := false
```

## Debug language features such as type inference and reduction.

```liquidsoap
settings.debug := false
```

## Debug errors by showing stacktraces instead of printing messages.

```liquidsoap
settings.debug_errors := false
```

## Decoder settings

### Maximum debugging information (dev only)

WARNING: Do not enable unless a developer instructed you to do so!The debugging mode makes it easier to understand why decoding fails,but as a side effect it will crash liquidsoap at the end of everytrack.

```liquidsoap
settings.decoder.debug := false
```

### Media decoders.

```liquidsoap
settings.decoder.decoders := ["wav", "aiff", "pcm/basic", "srt", "raw audio", "midi", "image", "aac", "mp4", "ffmpeg", "flac", "ogg", "mad"]
```

### FFmpeg decoder configuration

#### Codecs settings

##### Preferred codec to decode 4xm

```liquidsoap
settings.decoder.ffmpeg.codecs._4xm := <value>
```

###### Available codecs to decode 4xm

```liquidsoap
settings.decoder.ffmpeg.codecs._4xm.available := ["4xm"]
```

##### Preferred codec to decode aac

```liquidsoap
settings.decoder.ffmpeg.codecs.aac := <value>
```

###### Available codecs to decode aac

```liquidsoap
settings.decoder.ffmpeg.codecs.aac.available := ["aac", "aac_fixed", "libfdk_aac"]
```

##### Preferred codec to decode aasc

```liquidsoap
settings.decoder.ffmpeg.codecs.aasc := <value>
```

###### Available codecs to decode aasc

```liquidsoap
settings.decoder.ffmpeg.codecs.aasc.available := ["aasc"]
```

##### Preferred codec to decode ac3

```liquidsoap
settings.decoder.ffmpeg.codecs.ac3 := <value>
```

###### Available codecs to decode ac3

```liquidsoap
settings.decoder.ffmpeg.codecs.ac3.available := ["ac3", "ac3_fixed"]
```

##### Preferred codec to decode acelp.kelvin

```liquidsoap
settings.decoder.ffmpeg.codecs.acelpkelvin := <value>
```

###### Available codecs to decode acelp.kelvin

```liquidsoap
settings.decoder.ffmpeg.codecs.acelpkelvin.available := ["acelp.kelvin"]
```

##### Preferred codec to decode adpcm_4xm

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_4xm := <value>
```

###### Available codecs to decode adpcm_4xm

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_4xm.available := ["adpcm_4xm"]
```

##### Preferred codec to decode adpcm_adx

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_adx := <value>
```

###### Available codecs to decode adpcm_adx

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_adx.available := ["adpcm_adx"]
```

##### Preferred codec to decode adpcm_afc

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_afc := <value>
```

###### Available codecs to decode adpcm_afc

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_afc.available := ["adpcm_afc"]
```

##### Preferred codec to decode adpcm_agm

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_agm := <value>
```

###### Available codecs to decode adpcm_agm

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_agm.available := ["adpcm_agm"]
```

##### Preferred codec to decode adpcm_dtk

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_dtk := <value>
```

###### Available codecs to decode adpcm_dtk

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_dtk.available := ["adpcm_dtk"]
```

##### Preferred codec to decode adpcm_ea_xas

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ea_xas := <value>
```

###### Available codecs to decode adpcm_ea_xas

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ea_xas.available := ["adpcm_ea_xas"]
```

##### Preferred codec to decode adpcm_g726le

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_g726le := <value>
```

###### Available codecs to decode adpcm_g726le

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_g726le.available := ["g726le"]
```

##### Preferred codec to decode adpcm_ima_ea_eacs

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_ea_eacs := <value>
```

###### Available codecs to decode adpcm_ima_ea_eacs

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_ea_eacs.available := ["adpcm_ima_ea_eacs"]
```

##### Preferred codec to decode adpcm_ima_ea_sead

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_ea_sead := <value>
```

###### Available codecs to decode adpcm_ima_ea_sead

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_ea_sead.available := ["adpcm_ima_ea_sead"]
```

##### Preferred codec to decode adpcm_ima_qt

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_qt := <value>
```

###### Available codecs to decode adpcm_ima_qt

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_qt.available := ["adpcm_ima_qt"]
```

##### Preferred codec to decode adpcm_ima_smjpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_smjpeg := <value>
```

###### Available codecs to decode adpcm_ima_smjpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_smjpeg.available := ["adpcm_ima_smjpeg"]
```

##### Preferred codec to decode adpcm_ima_ws

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_ws := <value>
```

###### Available codecs to decode adpcm_ima_ws

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_ws.available := ["adpcm_ima_ws"]
```

##### Preferred codec to decode adpcm_psx

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_psx := <value>
```

###### Available codecs to decode adpcm_psx

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_psx.available := ["adpcm_psx"]
```

##### Preferred codec to decode adpcm_swf

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_swf := <value>
```

###### Available codecs to decode adpcm_swf

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_swf.available := ["adpcm_swf"]
```

##### Preferred codec to decode adpcm_thp

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_thp := <value>
```

###### Available codecs to decode adpcm_thp

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_thp.available := ["adpcm_thp"]
```

##### Preferred codec to decode adpcm_thp_le

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_thp_le := <value>
```

###### Available codecs to decode adpcm_thp_le

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_thp_le.available := ["adpcm_thp_le"]
```

##### Preferred codec to decode adpcm_xmd

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_xmd := <value>
```

###### Available codecs to decode adpcm_xmd

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_xmd.available := ["adpcm_xmd"]
```

##### Preferred codec to decode adpcm_yamaha

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_yamaha := <value>
```

###### Available codecs to decode adpcm_yamaha

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_yamaha.available := ["adpcm_yamaha"]
```

##### Preferred codec to decode agm

```liquidsoap
settings.decoder.ffmpeg.codecs.agm := <value>
```

###### Available codecs to decode agm

```liquidsoap
settings.decoder.ffmpeg.codecs.agm.available := ["agm"]
```

##### Preferred codec to decode aic

```liquidsoap
settings.decoder.ffmpeg.codecs.aic := <value>
```

###### Available codecs to decode aic

```liquidsoap
settings.decoder.ffmpeg.codecs.aic.available := ["aic"]
```

##### Preferred codec to decode alac

```liquidsoap
settings.decoder.ffmpeg.codecs.alac := <value>
```

###### Available codecs to decode alac

```liquidsoap
settings.decoder.ffmpeg.codecs.alac.available := ["alac"]
```

##### Preferred codec to decode amr_nb

```liquidsoap
settings.decoder.ffmpeg.codecs.amr_nb := <value>
```

###### Available codecs to decode amr_nb

```liquidsoap
settings.decoder.ffmpeg.codecs.amr_nb.available := ["libopencore_amrnb"]
```

##### Preferred codec to decode amr_wb

```liquidsoap
settings.decoder.ffmpeg.codecs.amr_wb := <value>
```

###### Available codecs to decode amr_wb

```liquidsoap
settings.decoder.ffmpeg.codecs.amr_wb.available := ["amrwb", "libopencore_amrwb"]
```

##### Preferred codec to decode amv

```liquidsoap
settings.decoder.ffmpeg.codecs.amv := <value>
```

###### Available codecs to decode amv

```liquidsoap
settings.decoder.ffmpeg.codecs.amv.available := ["amv"]
```

##### Preferred codec to decode anm

```liquidsoap
settings.decoder.ffmpeg.codecs.anm := <value>
```

###### Available codecs to decode anm

```liquidsoap
settings.decoder.ffmpeg.codecs.anm.available := ["anm"]
```

##### Preferred codec to decode ansi

```liquidsoap
settings.decoder.ffmpeg.codecs.ansi := <value>
```

###### Available codecs to decode ansi

```liquidsoap
settings.decoder.ffmpeg.codecs.ansi.available := ["ansi"]
```

##### Preferred codec to decode apac

```liquidsoap
settings.decoder.ffmpeg.codecs.apac := <value>
```

###### Available codecs to decode apac

```liquidsoap
settings.decoder.ffmpeg.codecs.apac.available := ["apac"]
```

##### Preferred codec to decode ape

```liquidsoap
settings.decoder.ffmpeg.codecs.ape := <value>
```

###### Available codecs to decode ape

```liquidsoap
settings.decoder.ffmpeg.codecs.ape.available := ["ape"]
```

##### Preferred codec to decode apng

```liquidsoap
settings.decoder.ffmpeg.codecs.apng := <value>
```

###### Available codecs to decode apng

```liquidsoap
settings.decoder.ffmpeg.codecs.apng.available := ["apng"]
```

##### Preferred codec to decode aptx

```liquidsoap
settings.decoder.ffmpeg.codecs.aptx := <value>
```

###### Available codecs to decode aptx

```liquidsoap
settings.decoder.ffmpeg.codecs.aptx.available := ["aptx"]
```

##### Preferred codec to decode arbc

```liquidsoap
settings.decoder.ffmpeg.codecs.arbc := <value>
```

###### Available codecs to decode arbc

```liquidsoap
settings.decoder.ffmpeg.codecs.arbc.available := ["arbc"]
```

##### Preferred codec to decode argo

```liquidsoap
settings.decoder.ffmpeg.codecs.argo := <value>
```

###### Available codecs to decode argo

```liquidsoap
settings.decoder.ffmpeg.codecs.argo.available := ["argo"]
```

##### Preferred codec to decode asv1

```liquidsoap
settings.decoder.ffmpeg.codecs.asv1 := <value>
```

###### Available codecs to decode asv1

```liquidsoap
settings.decoder.ffmpeg.codecs.asv1.available := ["asv1"]
```

##### Preferred codec to decode asv2

```liquidsoap
settings.decoder.ffmpeg.codecs.asv2 := <value>
```

###### Available codecs to decode asv2

```liquidsoap
settings.decoder.ffmpeg.codecs.asv2.available := ["asv2"]
```

##### Preferred codec to decode atrac1

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac1 := <value>
```

###### Available codecs to decode atrac1

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac1.available := ["atrac1"]
```

##### Preferred codec to decode atrac3

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac3 := <value>
```

###### Available codecs to decode atrac3

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac3.available := ["atrac3"]
```

##### Preferred codec to decode atrac3al

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac3al := <value>
```

###### Available codecs to decode atrac3al

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac3al.available := ["atrac3al"]
```

##### Preferred codec to decode atrac9

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac9 := <value>
```

###### Available codecs to decode atrac9

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac9.available := ["atrac9"]
```

##### Preferred codec to decode aura

```liquidsoap
settings.decoder.ffmpeg.codecs.aura := <value>
```

###### Available codecs to decode aura

```liquidsoap
settings.decoder.ffmpeg.codecs.aura.available := ["aura"]
```

##### Preferred codec to decode aura2

```liquidsoap
settings.decoder.ffmpeg.codecs.aura2 := <value>
```

###### Available codecs to decode aura2

```liquidsoap
settings.decoder.ffmpeg.codecs.aura2.available := ["aura2"]
```

##### Preferred codec to decode av1

```liquidsoap
settings.decoder.ffmpeg.codecs.av1 := <value>
```

###### Available codecs to decode av1

```liquidsoap
settings.decoder.ffmpeg.codecs.av1.available := ["libdav1d", "libaom-av1", "av1", "av1_cuvid"]
```

##### Preferred codec to decode avc

```liquidsoap
settings.decoder.ffmpeg.codecs.avc := <value>
```

###### Available codecs to decode avc

```liquidsoap
settings.decoder.ffmpeg.codecs.avc.available := ["on2avc"]
```

##### Preferred codec to decode avrn

```liquidsoap
settings.decoder.ffmpeg.codecs.avrn := <value>
```

###### Available codecs to decode avrn

```liquidsoap
settings.decoder.ffmpeg.codecs.avrn.available := ["avrn"]
```

##### Preferred codec to decode avrp

```liquidsoap
settings.decoder.ffmpeg.codecs.avrp := <value>
```

###### Available codecs to decode avrp

```liquidsoap
settings.decoder.ffmpeg.codecs.avrp.available := ["avrp"]
```

##### Preferred codec to decode avs

```liquidsoap
settings.decoder.ffmpeg.codecs.avs := <value>
```

###### Available codecs to decode avs

```liquidsoap
settings.decoder.ffmpeg.codecs.avs.available := ["avs"]
```

##### Preferred codec to decode avs2

```liquidsoap
settings.decoder.ffmpeg.codecs.avs2 := <value>
```

###### Available codecs to decode avs2

```liquidsoap
settings.decoder.ffmpeg.codecs.avs2.available := ["libdavs2"]
```

##### Preferred codec to decode avui

```liquidsoap
settings.decoder.ffmpeg.codecs.avui := <value>
```

###### Available codecs to decode avui

```liquidsoap
settings.decoder.ffmpeg.codecs.avui.available := ["avui"]
```

##### Preferred codec to decode ayuv

```liquidsoap
settings.decoder.ffmpeg.codecs.ayuv := <value>
```

###### Available codecs to decode ayuv

```liquidsoap
settings.decoder.ffmpeg.codecs.ayuv.available := ["ayuv"]
```

##### Preferred codec to decode bethsoftvid

```liquidsoap
settings.decoder.ffmpeg.codecs.bethsoftvid := <value>
```

###### Available codecs to decode bethsoftvid

```liquidsoap
settings.decoder.ffmpeg.codecs.bethsoftvid.available := ["bethsoftvid"]
```

##### Preferred codec to decode bfi

```liquidsoap
settings.decoder.ffmpeg.codecs.bfi := <value>
```

###### Available codecs to decode bfi

```liquidsoap
settings.decoder.ffmpeg.codecs.bfi.available := ["bfi"]
```

##### Preferred codec to decode binkaudio_dct

```liquidsoap
settings.decoder.ffmpeg.codecs.binkaudio_dct := <value>
```

###### Available codecs to decode binkaudio_dct

```liquidsoap
settings.decoder.ffmpeg.codecs.binkaudio_dct.available := ["binkaudio_dct"]
```

##### Preferred codec to decode binkvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.binkvideo := <value>
```

###### Available codecs to decode binkvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.binkvideo.available := ["binkvideo"]
```

##### Preferred codec to decode bitpacked

```liquidsoap
settings.decoder.ffmpeg.codecs.bitpacked := <value>
```

###### Available codecs to decode bitpacked

```liquidsoap
settings.decoder.ffmpeg.codecs.bitpacked.available := ["bitpacked"]
```

##### Preferred codec to decode bmp

```liquidsoap
settings.decoder.ffmpeg.codecs.bmp := <value>
```

###### Available codecs to decode bmp

```liquidsoap
settings.decoder.ffmpeg.codecs.bmp.available := ["bmp"]
```

##### Preferred codec to decode bmv_audio

```liquidsoap
settings.decoder.ffmpeg.codecs.bmv_audio := <value>
```

###### Available codecs to decode bmv_audio

```liquidsoap
settings.decoder.ffmpeg.codecs.bmv_audio.available := ["bmv_audio"]
```

##### Preferred codec to decode bmv_video

```liquidsoap
settings.decoder.ffmpeg.codecs.bmv_video := <value>
```

###### Available codecs to decode bmv_video

```liquidsoap
settings.decoder.ffmpeg.codecs.bmv_video.available := ["bmv_video"]
```

##### Preferred codec to decode bonk

```liquidsoap
settings.decoder.ffmpeg.codecs.bonk := <value>
```

###### Available codecs to decode bonk

```liquidsoap
settings.decoder.ffmpeg.codecs.bonk.available := ["bonk"]
```

##### Preferred codec to decode brender_pix

```liquidsoap
settings.decoder.ffmpeg.codecs.brender_pix := <value>
```

###### Available codecs to decode brender_pix

```liquidsoap
settings.decoder.ffmpeg.codecs.brender_pix.available := ["brender_pix"]
```

##### Preferred codec to decode c93

```liquidsoap
settings.decoder.ffmpeg.codecs.c93 := <value>
```

###### Available codecs to decode c93

```liquidsoap
settings.decoder.ffmpeg.codecs.c93.available := ["c93"]
```

##### Preferred codec to decode cavs

```liquidsoap
settings.decoder.ffmpeg.codecs.cavs := <value>
```

###### Available codecs to decode cavs

```liquidsoap
settings.decoder.ffmpeg.codecs.cavs.available := ["cavs"]
```

##### Preferred codec to decode cdxl

```liquidsoap
settings.decoder.ffmpeg.codecs.cdxl := <value>
```

###### Available codecs to decode cdxl

```liquidsoap
settings.decoder.ffmpeg.codecs.cdxl.available := ["cdxl"]
```

##### Preferred codec to decode cfhd

```liquidsoap
settings.decoder.ffmpeg.codecs.cfhd := <value>
```

###### Available codecs to decode cfhd

```liquidsoap
settings.decoder.ffmpeg.codecs.cfhd.available := ["cfhd"]
```

##### Preferred codec to decode cljr

```liquidsoap
settings.decoder.ffmpeg.codecs.cljr := <value>
```

###### Available codecs to decode cljr

```liquidsoap
settings.decoder.ffmpeg.codecs.cljr.available := ["cljr"]
```

##### Preferred codec to decode cllc

```liquidsoap
settings.decoder.ffmpeg.codecs.cllc := <value>
```

###### Available codecs to decode cllc

```liquidsoap
settings.decoder.ffmpeg.codecs.cllc.available := ["cllc"]
```

##### Preferred codec to decode cmv

```liquidsoap
settings.decoder.ffmpeg.codecs.cmv := <value>
```

###### Available codecs to decode cmv

```liquidsoap
settings.decoder.ffmpeg.codecs.cmv.available := ["eacmv"]
```

##### Preferred codec to decode comfortnoise

```liquidsoap
settings.decoder.ffmpeg.codecs.comfortnoise := <value>
```

###### Available codecs to decode comfortnoise

```liquidsoap
settings.decoder.ffmpeg.codecs.comfortnoise.available := ["comfortnoise"]
```

##### Preferred codec to decode cook

```liquidsoap
settings.decoder.ffmpeg.codecs.cook := <value>
```

###### Available codecs to decode cook

```liquidsoap
settings.decoder.ffmpeg.codecs.cook.available := ["cook"]
```

##### Preferred codec to decode cpia

```liquidsoap
settings.decoder.ffmpeg.codecs.cpia := <value>
```

###### Available codecs to decode cpia

```liquidsoap
settings.decoder.ffmpeg.codecs.cpia.available := ["cpia"]
```

##### Preferred codec to decode cri

```liquidsoap
settings.decoder.ffmpeg.codecs.cri := <value>
```

###### Available codecs to decode cri

```liquidsoap
settings.decoder.ffmpeg.codecs.cri.available := ["cri"]
```

##### Preferred codec to decode cscd

```liquidsoap
settings.decoder.ffmpeg.codecs.cscd := <value>
```

###### Available codecs to decode cscd

```liquidsoap
settings.decoder.ffmpeg.codecs.cscd.available := ["camstudio"]
```

##### Preferred codec to decode cyuv

```liquidsoap
settings.decoder.ffmpeg.codecs.cyuv := <value>
```

###### Available codecs to decode cyuv

```liquidsoap
settings.decoder.ffmpeg.codecs.cyuv.available := ["cyuv"]
```

##### Preferred codec to decode dds

```liquidsoap
settings.decoder.ffmpeg.codecs.dds := <value>
```

###### Available codecs to decode dds

```liquidsoap
settings.decoder.ffmpeg.codecs.dds.available := ["dds"]
```

##### Preferred codec to decode dfa

```liquidsoap
settings.decoder.ffmpeg.codecs.dfa := <value>
```

###### Available codecs to decode dfa

```liquidsoap
settings.decoder.ffmpeg.codecs.dfa.available := ["dfa"]
```

##### Preferred codec to decode dpx

```liquidsoap
settings.decoder.ffmpeg.codecs.dpx := <value>
```

###### Available codecs to decode dpx

```liquidsoap
settings.decoder.ffmpeg.codecs.dpx.available := ["dpx"]
```

##### Preferred codec to decode dsd_lsbf_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.dsd_lsbf_planar := <value>
```

###### Available codecs to decode dsd_lsbf_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.dsd_lsbf_planar.available := ["dsd_lsbf_planar"]
```

##### Preferred codec to decode dsd_msbf_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.dsd_msbf_planar := <value>
```

###### Available codecs to decode dsd_msbf_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.dsd_msbf_planar.available := ["dsd_msbf_planar"]
```

##### Preferred codec to decode dsicinvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.dsicinvideo := <value>
```

###### Available codecs to decode dsicinvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.dsicinvideo.available := ["dsicinvideo"]
```

##### Preferred codec to decode dss_sp

```liquidsoap
settings.decoder.ffmpeg.codecs.dss_sp := <value>
```

###### Available codecs to decode dss_sp

```liquidsoap
settings.decoder.ffmpeg.codecs.dss_sp.available := ["dss_sp"]
```

##### Preferred codec to decode dst

```liquidsoap
settings.decoder.ffmpeg.codecs.dst := <value>
```

###### Available codecs to decode dst

```liquidsoap
settings.decoder.ffmpeg.codecs.dst.available := ["dst"]
```

##### Preferred codec to decode dts

```liquidsoap
settings.decoder.ffmpeg.codecs.dts := <value>
```

###### Available codecs to decode dts

```liquidsoap
settings.decoder.ffmpeg.codecs.dts.available := ["dca"]
```

##### Preferred codec to decode dxa

```liquidsoap
settings.decoder.ffmpeg.codecs.dxa := <value>
```

###### Available codecs to decode dxa

```liquidsoap
settings.decoder.ffmpeg.codecs.dxa.available := ["dxa"]
```

##### Preferred codec to decode dxtory

```liquidsoap
settings.decoder.ffmpeg.codecs.dxtory := <value>
```

###### Available codecs to decode dxtory

```liquidsoap
settings.decoder.ffmpeg.codecs.dxtory.available := ["dxtory"]
```

##### Preferred codec to decode dxv

```liquidsoap
settings.decoder.ffmpeg.codecs.dxv := <value>
```

###### Available codecs to decode dxv

```liquidsoap
settings.decoder.ffmpeg.codecs.dxv.available := ["dxv"]
```

##### Preferred codec to decode eac3

```liquidsoap
settings.decoder.ffmpeg.codecs.eac3 := <value>
```

###### Available codecs to decode eac3

```liquidsoap
settings.decoder.ffmpeg.codecs.eac3.available := ["eac3"]
```

##### Preferred codec to decode escape124

```liquidsoap
settings.decoder.ffmpeg.codecs.escape124 := <value>
```

###### Available codecs to decode escape124

```liquidsoap
settings.decoder.ffmpeg.codecs.escape124.available := ["escape124"]
```

##### Preferred codec to decode escape130

```liquidsoap
settings.decoder.ffmpeg.codecs.escape130 := <value>
```

###### Available codecs to decode escape130

```liquidsoap
settings.decoder.ffmpeg.codecs.escape130.available := ["escape130"]
```

##### Preferred codec to decode evrc

```liquidsoap
settings.decoder.ffmpeg.codecs.evrc := <value>
```

###### Available codecs to decode evrc

```liquidsoap
settings.decoder.ffmpeg.codecs.evrc.available := ["evrc"]
```

##### Preferred codec to decode exr

```liquidsoap
settings.decoder.ffmpeg.codecs.exr := <value>
```

###### Available codecs to decode exr

```liquidsoap
settings.decoder.ffmpeg.codecs.exr.available := ["exr"]
```

##### Preferred codec to decode fastaudio

```liquidsoap
settings.decoder.ffmpeg.codecs.fastaudio := <value>
```

###### Available codecs to decode fastaudio

```liquidsoap
settings.decoder.ffmpeg.codecs.fastaudio.available := ["fastaudio"]
```

##### Preferred codec to decode ffv1

```liquidsoap
settings.decoder.ffmpeg.codecs.ffv1 := <value>
```

###### Available codecs to decode ffv1

```liquidsoap
settings.decoder.ffmpeg.codecs.ffv1.available := ["ffv1"]
```

##### Preferred codec to decode fic

```liquidsoap
settings.decoder.ffmpeg.codecs.fic := <value>
```

###### Available codecs to decode fic

```liquidsoap
settings.decoder.ffmpeg.codecs.fic.available := ["fic"]
```

##### Preferred codec to decode fits

```liquidsoap
settings.decoder.ffmpeg.codecs.fits := <value>
```

###### Available codecs to decode fits

```liquidsoap
settings.decoder.ffmpeg.codecs.fits.available := ["fits"]
```

##### Preferred codec to decode flac

```liquidsoap
settings.decoder.ffmpeg.codecs.flac := <value>
```

###### Available codecs to decode flac

```liquidsoap
settings.decoder.ffmpeg.codecs.flac.available := ["flac"]
```

##### Preferred codec to decode flashsv

```liquidsoap
settings.decoder.ffmpeg.codecs.flashsv := <value>
```

###### Available codecs to decode flashsv

```liquidsoap
settings.decoder.ffmpeg.codecs.flashsv.available := ["flashsv"]
```

##### Preferred codec to decode flic

```liquidsoap
settings.decoder.ffmpeg.codecs.flic := <value>
```

###### Available codecs to decode flic

```liquidsoap
settings.decoder.ffmpeg.codecs.flic.available := ["flic"]
```

##### Preferred codec to decode flv1

```liquidsoap
settings.decoder.ffmpeg.codecs.flv1 := <value>
```

###### Available codecs to decode flv1

```liquidsoap
settings.decoder.ffmpeg.codecs.flv1.available := ["flv"]
```

##### Preferred codec to decode fmvc

```liquidsoap
settings.decoder.ffmpeg.codecs.fmvc := <value>
```

###### Available codecs to decode fmvc

```liquidsoap
settings.decoder.ffmpeg.codecs.fmvc.available := ["fmvc"]
```

##### Preferred codec to decode fraps

```liquidsoap
settings.decoder.ffmpeg.codecs.fraps := <value>
```

###### Available codecs to decode fraps

```liquidsoap
settings.decoder.ffmpeg.codecs.fraps.available := ["fraps"]
```

##### Preferred codec to decode frwu

```liquidsoap
settings.decoder.ffmpeg.codecs.frwu := <value>
```

###### Available codecs to decode frwu

```liquidsoap
settings.decoder.ffmpeg.codecs.frwu.available := ["frwu"]
```

##### Preferred codec to decode ftr

```liquidsoap
settings.decoder.ffmpeg.codecs.ftr := <value>
```

###### Available codecs to decode ftr

```liquidsoap
settings.decoder.ffmpeg.codecs.ftr.available := ["ftr"]
```

##### Preferred codec to decode g2m

```liquidsoap
settings.decoder.ffmpeg.codecs.g2m := <value>
```

###### Available codecs to decode g2m

```liquidsoap
settings.decoder.ffmpeg.codecs.g2m.available := ["g2m"]
```

##### Preferred codec to decode g723_1

```liquidsoap
settings.decoder.ffmpeg.codecs.g723_1 := <value>
```

###### Available codecs to decode g723_1

```liquidsoap
settings.decoder.ffmpeg.codecs.g723_1.available := ["g723_1"]
```

##### Preferred codec to decode g729

```liquidsoap
settings.decoder.ffmpeg.codecs.g729 := <value>
```

###### Available codecs to decode g729

```liquidsoap
settings.decoder.ffmpeg.codecs.g729.available := ["g729"]
```

##### Preferred codec to decode gdv

```liquidsoap
settings.decoder.ffmpeg.codecs.gdv := <value>
```

###### Available codecs to decode gdv

```liquidsoap
settings.decoder.ffmpeg.codecs.gdv.available := ["gdv"]
```

##### Preferred codec to decode gem

```liquidsoap
settings.decoder.ffmpeg.codecs.gem := <value>
```

###### Available codecs to decode gem

```liquidsoap
settings.decoder.ffmpeg.codecs.gem.available := ["gem"]
```

##### Preferred codec to decode gif

```liquidsoap
settings.decoder.ffmpeg.codecs.gif := <value>
```

###### Available codecs to decode gif

```liquidsoap
settings.decoder.ffmpeg.codecs.gif.available := ["gif"]
```

##### Preferred codec to decode gsm

```liquidsoap
settings.decoder.ffmpeg.codecs.gsm := <value>
```

###### Available codecs to decode gsm

```liquidsoap
settings.decoder.ffmpeg.codecs.gsm.available := ["gsm", "libgsm"]
```

##### Preferred codec to decode h261

```liquidsoap
settings.decoder.ffmpeg.codecs.h261 := <value>
```

###### Available codecs to decode h261

```liquidsoap
settings.decoder.ffmpeg.codecs.h261.available := ["h261"]
```

##### Preferred codec to decode h263

```liquidsoap
settings.decoder.ffmpeg.codecs.h263 := <value>
```

###### Available codecs to decode h263

```liquidsoap
settings.decoder.ffmpeg.codecs.h263.available := ["h263", "h263_v4l2m2m"]
```

##### Preferred codec to decode h263i

```liquidsoap
settings.decoder.ffmpeg.codecs.h263i := <value>
```

###### Available codecs to decode h263i

```liquidsoap
settings.decoder.ffmpeg.codecs.h263i.available := ["h263i"]
```

##### Preferred codec to decode h263p

```liquidsoap
settings.decoder.ffmpeg.codecs.h263p := <value>
```

###### Available codecs to decode h263p

```liquidsoap
settings.decoder.ffmpeg.codecs.h263p.available := ["h263p"]
```

##### Preferred codec to decode h264

```liquidsoap
settings.decoder.ffmpeg.codecs.h264 := <value>
```

###### Available codecs to decode h264

```liquidsoap
settings.decoder.ffmpeg.codecs.h264.available := ["h264", "h264_v4l2m2m", "libopenh264", "h264_cuvid"]
```

##### Preferred codec to decode hap

```liquidsoap
settings.decoder.ffmpeg.codecs.hap := <value>
```

###### Available codecs to decode hap

```liquidsoap
settings.decoder.ffmpeg.codecs.hap.available := ["hap"]
```

##### Preferred codec to decode hca

```liquidsoap
settings.decoder.ffmpeg.codecs.hca := <value>
```

###### Available codecs to decode hca

```liquidsoap
settings.decoder.ffmpeg.codecs.hca.available := ["hca"]
```

##### Preferred codec to decode hcom

```liquidsoap
settings.decoder.ffmpeg.codecs.hcom := <value>
```

###### Available codecs to decode hcom

```liquidsoap
settings.decoder.ffmpeg.codecs.hcom.available := ["hcom"]
```

##### Preferred codec to decode hdr

```liquidsoap
settings.decoder.ffmpeg.codecs.hdr := <value>
```

###### Available codecs to decode hdr

```liquidsoap
settings.decoder.ffmpeg.codecs.hdr.available := ["hdr"]
```

##### Preferred codec to decode hevc

```liquidsoap
settings.decoder.ffmpeg.codecs.hevc := <value>
```

###### Available codecs to decode hevc

```liquidsoap
settings.decoder.ffmpeg.codecs.hevc.available := ["hevc", "hevc_v4l2m2m", "hevc_cuvid"]
```

##### Preferred codec to decode hnm4video

```liquidsoap
settings.decoder.ffmpeg.codecs.hnm4video := <value>
```

###### Available codecs to decode hnm4video

```liquidsoap
settings.decoder.ffmpeg.codecs.hnm4video.available := ["hnm4video"]
```

##### Preferred codec to decode hq_hqa

```liquidsoap
settings.decoder.ffmpeg.codecs.hq_hqa := <value>
```

###### Available codecs to decode hq_hqa

```liquidsoap
settings.decoder.ffmpeg.codecs.hq_hqa.available := ["hq_hqa"]
```

##### Preferred codec to decode hqx

```liquidsoap
settings.decoder.ffmpeg.codecs.hqx := <value>
```

###### Available codecs to decode hqx

```liquidsoap
settings.decoder.ffmpeg.codecs.hqx.available := ["hqx"]
```

##### Preferred codec to decode hymt

```liquidsoap
settings.decoder.ffmpeg.codecs.hymt := <value>
```

###### Available codecs to decode hymt

```liquidsoap
settings.decoder.ffmpeg.codecs.hymt.available := ["hymt"]
```

##### Preferred codec to decode iac

```liquidsoap
settings.decoder.ffmpeg.codecs.iac := <value>
```

###### Available codecs to decode iac

```liquidsoap
settings.decoder.ffmpeg.codecs.iac.available := ["iac"]
```

##### Preferred codec to decode iff_ilbm

```liquidsoap
settings.decoder.ffmpeg.codecs.iff_ilbm := <value>
```

###### Available codecs to decode iff_ilbm

```liquidsoap
settings.decoder.ffmpeg.codecs.iff_ilbm.available := ["iff"]
```

##### Preferred codec to decode ilbc

```liquidsoap
settings.decoder.ffmpeg.codecs.ilbc := <value>
```

###### Available codecs to decode ilbc

```liquidsoap
settings.decoder.ffmpeg.codecs.ilbc.available := ["ilbc", "libilbc"]
```

##### Preferred codec to decode imc

```liquidsoap
settings.decoder.ffmpeg.codecs.imc := <value>
```

###### Available codecs to decode imc

```liquidsoap
settings.decoder.ffmpeg.codecs.imc.available := ["imc"]
```

##### Preferred codec to decode imm4

```liquidsoap
settings.decoder.ffmpeg.codecs.imm4 := <value>
```

###### Available codecs to decode imm4

```liquidsoap
settings.decoder.ffmpeg.codecs.imm4.available := ["imm4"]
```

##### Preferred codec to decode imm5

```liquidsoap
settings.decoder.ffmpeg.codecs.imm5 := <value>
```

###### Available codecs to decode imm5

```liquidsoap
settings.decoder.ffmpeg.codecs.imm5.available := ["imm5"]
```

##### Preferred codec to decode interplayacm

```liquidsoap
settings.decoder.ffmpeg.codecs.interplayacm := <value>
```

###### Available codecs to decode interplayacm

```liquidsoap
settings.decoder.ffmpeg.codecs.interplayacm.available := ["interplayacm"]
```

##### Preferred codec to decode interplayvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.interplayvideo := <value>
```

###### Available codecs to decode interplayvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.interplayvideo.available := ["interplayvideo"]
```

##### Preferred codec to decode ipu

```liquidsoap
settings.decoder.ffmpeg.codecs.ipu := <value>
```

###### Available codecs to decode ipu

```liquidsoap
settings.decoder.ffmpeg.codecs.ipu.available := ["ipu"]
```

##### Preferred codec to decode jpeg2000

```liquidsoap
settings.decoder.ffmpeg.codecs.jpeg2000 := <value>
```

###### Available codecs to decode jpeg2000

```liquidsoap
settings.decoder.ffmpeg.codecs.jpeg2000.available := ["jpeg2000"]
```

##### Preferred codec to decode jv

```liquidsoap
settings.decoder.ffmpeg.codecs.jv := <value>
```

###### Available codecs to decode jv

```liquidsoap
settings.decoder.ffmpeg.codecs.jv.available := ["jv"]
```

##### Preferred codec to decode kgv1

```liquidsoap
settings.decoder.ffmpeg.codecs.kgv1 := <value>
```

###### Available codecs to decode kgv1

```liquidsoap
settings.decoder.ffmpeg.codecs.kgv1.available := ["kgv1"]
```

##### Preferred codec to decode kmvc

```liquidsoap
settings.decoder.ffmpeg.codecs.kmvc := <value>
```

###### Available codecs to decode kmvc

```liquidsoap
settings.decoder.ffmpeg.codecs.kmvc.available := ["kmvc"]
```

##### Preferred codec to decode lagarith

```liquidsoap
settings.decoder.ffmpeg.codecs.lagarith := <value>
```

###### Available codecs to decode lagarith

```liquidsoap
settings.decoder.ffmpeg.codecs.lagarith.available := ["lagarith"]
```

##### Preferred codec to decode loco

```liquidsoap
settings.decoder.ffmpeg.codecs.loco := <value>
```

###### Available codecs to decode loco

```liquidsoap
settings.decoder.ffmpeg.codecs.loco.available := ["loco"]
```

##### Preferred codec to decode lscr

```liquidsoap
settings.decoder.ffmpeg.codecs.lscr := <value>
```

###### Available codecs to decode lscr

```liquidsoap
settings.decoder.ffmpeg.codecs.lscr.available := ["lscr"]
```

##### Preferred codec to decode m101

```liquidsoap
settings.decoder.ffmpeg.codecs.m101 := <value>
```

###### Available codecs to decode m101

```liquidsoap
settings.decoder.ffmpeg.codecs.m101.available := ["m101"]
```

##### Preferred codec to decode mace3

```liquidsoap
settings.decoder.ffmpeg.codecs.mace3 := <value>
```

###### Available codecs to decode mace3

```liquidsoap
settings.decoder.ffmpeg.codecs.mace3.available := ["mace3"]
```

##### Preferred codec to decode mace6

```liquidsoap
settings.decoder.ffmpeg.codecs.mace6 := <value>
```

###### Available codecs to decode mace6

```liquidsoap
settings.decoder.ffmpeg.codecs.mace6.available := ["mace6"]
```

##### Preferred codec to decode mad

```liquidsoap
settings.decoder.ffmpeg.codecs.mad := <value>
```

###### Available codecs to decode mad

```liquidsoap
settings.decoder.ffmpeg.codecs.mad.available := ["eamad"]
```

##### Preferred codec to decode mdec

```liquidsoap
settings.decoder.ffmpeg.codecs.mdec := <value>
```

###### Available codecs to decode mdec

```liquidsoap
settings.decoder.ffmpeg.codecs.mdec.available := ["mdec"]
```

##### Preferred codec to decode metasound

```liquidsoap
settings.decoder.ffmpeg.codecs.metasound := <value>
```

###### Available codecs to decode metasound

```liquidsoap
settings.decoder.ffmpeg.codecs.metasound.available := ["metasound"]
```

##### Preferred codec to decode mimic

```liquidsoap
settings.decoder.ffmpeg.codecs.mimic := <value>
```

###### Available codecs to decode mimic

```liquidsoap
settings.decoder.ffmpeg.codecs.mimic.available := ["mimic"]
```

##### Preferred codec to decode misc4

```liquidsoap
settings.decoder.ffmpeg.codecs.misc4 := <value>
```

###### Available codecs to decode misc4

```liquidsoap
settings.decoder.ffmpeg.codecs.misc4.available := ["misc4"]
```

##### Preferred codec to decode mjpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.mjpeg := <value>
```

###### Available codecs to decode mjpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.mjpeg.available := ["mjpeg", "mjpeg_cuvid"]
```

##### Preferred codec to decode mjpegb

```liquidsoap
settings.decoder.ffmpeg.codecs.mjpegb := <value>
```

###### Available codecs to decode mjpegb

```liquidsoap
settings.decoder.ffmpeg.codecs.mjpegb.available := ["mjpegb"]
```

##### Preferred codec to decode mlp

```liquidsoap
settings.decoder.ffmpeg.codecs.mlp := <value>
```

###### Available codecs to decode mlp

```liquidsoap
settings.decoder.ffmpeg.codecs.mlp.available := ["mlp"]
```

##### Preferred codec to decode mobiclip

```liquidsoap
settings.decoder.ffmpeg.codecs.mobiclip := <value>
```

###### Available codecs to decode mobiclip

```liquidsoap
settings.decoder.ffmpeg.codecs.mobiclip.available := ["mobiclip"]
```

##### Preferred codec to decode motionpixels

```liquidsoap
settings.decoder.ffmpeg.codecs.motionpixels := <value>
```

###### Available codecs to decode motionpixels

```liquidsoap
settings.decoder.ffmpeg.codecs.motionpixels.available := ["motionpixels"]
```

##### Preferred codec to decode mp1

```liquidsoap
settings.decoder.ffmpeg.codecs.mp1 := <value>
```

###### Available codecs to decode mp1

```liquidsoap
settings.decoder.ffmpeg.codecs.mp1.available := ["mp1", "mp1float"]
```

##### Preferred codec to decode mp2

```liquidsoap
settings.decoder.ffmpeg.codecs.mp2 := <value>
```

###### Available codecs to decode mp2

```liquidsoap
settings.decoder.ffmpeg.codecs.mp2.available := ["mp2", "mp2float"]
```

##### Preferred codec to decode mp3

```liquidsoap
settings.decoder.ffmpeg.codecs.mp3 := <value>
```

###### Available codecs to decode mp3

```liquidsoap
settings.decoder.ffmpeg.codecs.mp3.available := ["mp3float", "mp3"]
```

##### Preferred codec to decode mpeg1video

```liquidsoap
settings.decoder.ffmpeg.codecs.mpeg1video := <value>
```

###### Available codecs to decode mpeg1video

```liquidsoap
settings.decoder.ffmpeg.codecs.mpeg1video.available := ["mpeg1video", "mpeg1_v4l2m2m", "mpeg1_cuvid"]
```

##### Preferred codec to decode mpeg2video

```liquidsoap
settings.decoder.ffmpeg.codecs.mpeg2video := <value>
```

###### Available codecs to decode mpeg2video

```liquidsoap
settings.decoder.ffmpeg.codecs.mpeg2video.available := ["mpeg2video", "mpegvideo", "mpeg2_v4l2m2m", "mpeg2_cuvid"]
```

##### Preferred codec to decode mpeg4

```liquidsoap
settings.decoder.ffmpeg.codecs.mpeg4 := <value>
```

###### Available codecs to decode mpeg4

```liquidsoap
settings.decoder.ffmpeg.codecs.mpeg4.available := ["mpeg4", "mpeg4_v4l2m2m", "mpeg4_cuvid"]
```

##### Preferred codec to decode msa1

```liquidsoap
settings.decoder.ffmpeg.codecs.msa1 := <value>
```

###### Available codecs to decode msa1

```liquidsoap
settings.decoder.ffmpeg.codecs.msa1.available := ["msa1"]
```

##### Preferred codec to decode mscc

```liquidsoap
settings.decoder.ffmpeg.codecs.mscc := <value>
```

###### Available codecs to decode mscc

```liquidsoap
settings.decoder.ffmpeg.codecs.mscc.available := ["mscc"]
```

##### Preferred codec to decode msmpeg4v1

```liquidsoap
settings.decoder.ffmpeg.codecs.msmpeg4v1 := <value>
```

###### Available codecs to decode msmpeg4v1

```liquidsoap
settings.decoder.ffmpeg.codecs.msmpeg4v1.available := ["msmpeg4v1"]
```

##### Preferred codec to decode msmpeg4v2

```liquidsoap
settings.decoder.ffmpeg.codecs.msmpeg4v2 := <value>
```

###### Available codecs to decode msmpeg4v2

```liquidsoap
settings.decoder.ffmpeg.codecs.msmpeg4v2.available := ["msmpeg4v2"]
```

##### Preferred codec to decode msmpeg4v3

```liquidsoap
settings.decoder.ffmpeg.codecs.msmpeg4v3 := <value>
```

###### Available codecs to decode msmpeg4v3

```liquidsoap
settings.decoder.ffmpeg.codecs.msmpeg4v3.available := ["msmpeg4"]
```

##### Preferred codec to decode msp2

```liquidsoap
settings.decoder.ffmpeg.codecs.msp2 := <value>
```

###### Available codecs to decode msp2

```liquidsoap
settings.decoder.ffmpeg.codecs.msp2.available := ["msp2"]
```

##### Preferred codec to decode msrle

```liquidsoap
settings.decoder.ffmpeg.codecs.msrle := <value>
```

###### Available codecs to decode msrle

```liquidsoap
settings.decoder.ffmpeg.codecs.msrle.available := ["msrle"]
```

##### Preferred codec to decode mss1

```liquidsoap
settings.decoder.ffmpeg.codecs.mss1 := <value>
```

###### Available codecs to decode mss1

```liquidsoap
settings.decoder.ffmpeg.codecs.mss1.available := ["mss1"]
```

##### Preferred codec to decode mss2

```liquidsoap
settings.decoder.ffmpeg.codecs.mss2 := <value>
```

###### Available codecs to decode mss2

```liquidsoap
settings.decoder.ffmpeg.codecs.mss2.available := ["mss2"]
```

##### Preferred codec to decode mszh

```liquidsoap
settings.decoder.ffmpeg.codecs.mszh := <value>
```

###### Available codecs to decode mszh

```liquidsoap
settings.decoder.ffmpeg.codecs.mszh.available := ["mszh"]
```

##### Preferred codec to decode mts2

```liquidsoap
settings.decoder.ffmpeg.codecs.mts2 := <value>
```

###### Available codecs to decode mts2

```liquidsoap
settings.decoder.ffmpeg.codecs.mts2.available := ["mts2"]
```

##### Preferred codec to decode mv30

```liquidsoap
settings.decoder.ffmpeg.codecs.mv30 := <value>
```

###### Available codecs to decode mv30

```liquidsoap
settings.decoder.ffmpeg.codecs.mv30.available := ["mv30"]
```

##### Preferred codec to decode mvc1

```liquidsoap
settings.decoder.ffmpeg.codecs.mvc1 := <value>
```

###### Available codecs to decode mvc1

```liquidsoap
settings.decoder.ffmpeg.codecs.mvc1.available := ["mvc1"]
```

##### Preferred codec to decode mvc2

```liquidsoap
settings.decoder.ffmpeg.codecs.mvc2 := <value>
```

###### Available codecs to decode mvc2

```liquidsoap
settings.decoder.ffmpeg.codecs.mvc2.available := ["mvc2"]
```

##### Preferred codec to decode mvdv

```liquidsoap
settings.decoder.ffmpeg.codecs.mvdv := <value>
```

###### Available codecs to decode mvdv

```liquidsoap
settings.decoder.ffmpeg.codecs.mvdv.available := ["mvdv"]
```

##### Preferred codec to decode mvha

```liquidsoap
settings.decoder.ffmpeg.codecs.mvha := <value>
```

###### Available codecs to decode mvha

```liquidsoap
settings.decoder.ffmpeg.codecs.mvha.available := ["mvha"]
```

##### Preferred codec to decode mwsc

```liquidsoap
settings.decoder.ffmpeg.codecs.mwsc := <value>
```

###### Available codecs to decode mwsc

```liquidsoap
settings.decoder.ffmpeg.codecs.mwsc.available := ["mwsc"]
```

##### Preferred codec to decode mxpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.mxpeg := <value>
```

###### Available codecs to decode mxpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.mxpeg.available := ["mxpeg"]
```

##### Preferred codec to decode notchlc

```liquidsoap
settings.decoder.ffmpeg.codecs.notchlc := <value>
```

###### Available codecs to decode notchlc

```liquidsoap
settings.decoder.ffmpeg.codecs.notchlc.available := ["notchlc"]
```

##### Preferred codec to decode nuv

```liquidsoap
settings.decoder.ffmpeg.codecs.nuv := <value>
```

###### Available codecs to decode nuv

```liquidsoap
settings.decoder.ffmpeg.codecs.nuv.available := ["nuv"]
```

##### Preferred codec to decode opus

```liquidsoap
settings.decoder.ffmpeg.codecs.opus := <value>
```

###### Available codecs to decode opus

```liquidsoap
settings.decoder.ffmpeg.codecs.opus.available := ["opus", "libopus"]
```

##### Preferred codec to decode pam

```liquidsoap
settings.decoder.ffmpeg.codecs.pam := <value>
```

###### Available codecs to decode pam

```liquidsoap
settings.decoder.ffmpeg.codecs.pam.available := ["pam"]
```

##### Preferred codec to decode pbm

```liquidsoap
settings.decoder.ffmpeg.codecs.pbm := <value>
```

###### Available codecs to decode pbm

```liquidsoap
settings.decoder.ffmpeg.codecs.pbm.available := ["pbm"]
```

##### Preferred codec to decode pcm_bluray

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_bluray := <value>
```

###### Available codecs to decode pcm_bluray

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_bluray.available := ["pcm_bluray"]
```

##### Preferred codec to decode pcm_dvd

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_dvd := <value>
```

###### Available codecs to decode pcm_dvd

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_dvd.available := ["pcm_dvd"]
```

##### Preferred codec to decode pcm_f16le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f16le := <value>
```

###### Available codecs to decode pcm_f16le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f16le.available := ["pcm_f16le"]
```

##### Preferred codec to decode pcm_f24le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f24le := <value>
```

###### Available codecs to decode pcm_f24le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f24le.available := ["pcm_f24le"]
```

##### Preferred codec to decode pcm_f32be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f32be := <value>
```

###### Available codecs to decode pcm_f32be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f32be.available := ["pcm_f32be"]
```

##### Preferred codec to decode pcm_f32le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f32le := <value>
```

###### Available codecs to decode pcm_f32le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f32le.available := ["pcm_f32le"]
```

##### Preferred codec to decode pcm_f64be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f64be := <value>
```

###### Available codecs to decode pcm_f64be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f64be.available := ["pcm_f64be"]
```

##### Preferred codec to decode pcm_f64le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f64le := <value>
```

###### Available codecs to decode pcm_f64le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f64le.available := ["pcm_f64le"]
```

##### Preferred codec to decode pcm_lxf

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_lxf := <value>
```

###### Available codecs to decode pcm_lxf

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_lxf.available := ["pcm_lxf"]
```

##### Preferred codec to decode pcm_s16be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s16be := <value>
```

###### Available codecs to decode pcm_s16be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s16be.available := ["pcm_s16be"]
```

##### Preferred codec to decode pcm_s16le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s16le := <value>
```

###### Available codecs to decode pcm_s16le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s16le.available := ["pcm_s16le"]
```

##### Preferred codec to decode pcm_s16le_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s16le_planar := <value>
```

###### Available codecs to decode pcm_s16le_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s16le_planar.available := ["pcm_s16le_planar"]
```

##### Preferred codec to decode pcm_s24be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24be := <value>
```

###### Available codecs to decode pcm_s24be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24be.available := ["pcm_s24be"]
```

##### Preferred codec to decode pcm_s24daud

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24daud := <value>
```

###### Available codecs to decode pcm_s24daud

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24daud.available := ["pcm_s24daud"]
```

##### Preferred codec to decode pcm_s24le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24le := <value>
```

###### Available codecs to decode pcm_s24le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24le.available := ["pcm_s24le"]
```

##### Preferred codec to decode pcm_s24le_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24le_planar := <value>
```

###### Available codecs to decode pcm_s24le_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24le_planar.available := ["pcm_s24le_planar"]
```

##### Preferred codec to decode pcm_s32be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s32be := <value>
```

###### Available codecs to decode pcm_s32be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s32be.available := ["pcm_s32be"]
```

##### Preferred codec to decode pcm_s32le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s32le := <value>
```

###### Available codecs to decode pcm_s32le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s32le.available := ["pcm_s32le"]
```

##### Preferred codec to decode pcm_s32le_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s32le_planar := <value>
```

###### Available codecs to decode pcm_s32le_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s32le_planar.available := ["pcm_s32le_planar"]
```

##### Preferred codec to decode pcm_s64be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s64be := <value>
```

###### Available codecs to decode pcm_s64be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s64be.available := ["pcm_s64be"]
```

##### Preferred codec to decode pcm_s64le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s64le := <value>
```

###### Available codecs to decode pcm_s64le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s64le.available := ["pcm_s64le"]
```

##### Preferred codec to decode pcm_sga

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_sga := <value>
```

###### Available codecs to decode pcm_sga

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_sga.available := ["pcm_sga"]
```

##### Preferred codec to decode pcm_u16be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u16be := <value>
```

###### Available codecs to decode pcm_u16be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u16be.available := ["pcm_u16be"]
```

##### Preferred codec to decode pcm_u16le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u16le := <value>
```

###### Available codecs to decode pcm_u16le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u16le.available := ["pcm_u16le"]
```

##### Preferred codec to decode pcm_u24be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u24be := <value>
```

###### Available codecs to decode pcm_u24be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u24be.available := ["pcm_u24be"]
```

##### Preferred codec to decode pcm_u24le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u24le := <value>
```

###### Available codecs to decode pcm_u24le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u24le.available := ["pcm_u24le"]
```

##### Preferred codec to decode pcm_u32be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u32be := <value>
```

###### Available codecs to decode pcm_u32be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u32be.available := ["pcm_u32be"]
```

##### Preferred codec to decode pcm_u32le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u32le := <value>
```

###### Available codecs to decode pcm_u32le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u32le.available := ["pcm_u32le"]
```

##### Preferred codec to decode pcm_vidc

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_vidc := <value>
```

###### Available codecs to decode pcm_vidc

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_vidc.available := ["pcm_vidc"]
```

##### Preferred codec to decode pcx

```liquidsoap
settings.decoder.ffmpeg.codecs.pcx := <value>
```

###### Available codecs to decode pcx

```liquidsoap
settings.decoder.ffmpeg.codecs.pcx.available := ["pcx"]
```

##### Preferred codec to decode pfm

```liquidsoap
settings.decoder.ffmpeg.codecs.pfm := <value>
```

###### Available codecs to decode pfm

```liquidsoap
settings.decoder.ffmpeg.codecs.pfm.available := ["pfm"]
```

##### Preferred codec to decode pgm

```liquidsoap
settings.decoder.ffmpeg.codecs.pgm := <value>
```

###### Available codecs to decode pgm

```liquidsoap
settings.decoder.ffmpeg.codecs.pgm.available := ["pgm"]
```

##### Preferred codec to decode pgmyuv

```liquidsoap
settings.decoder.ffmpeg.codecs.pgmyuv := <value>
```

###### Available codecs to decode pgmyuv

```liquidsoap
settings.decoder.ffmpeg.codecs.pgmyuv.available := ["pgmyuv"]
```

##### Preferred codec to decode pgx

```liquidsoap
settings.decoder.ffmpeg.codecs.pgx := <value>
```

###### Available codecs to decode pgx

```liquidsoap
settings.decoder.ffmpeg.codecs.pgx.available := ["pgx"]
```

##### Preferred codec to decode phm

```liquidsoap
settings.decoder.ffmpeg.codecs.phm := <value>
```

###### Available codecs to decode phm

```liquidsoap
settings.decoder.ffmpeg.codecs.phm.available := ["phm"]
```

##### Preferred codec to decode pictor

```liquidsoap
settings.decoder.ffmpeg.codecs.pictor := <value>
```

###### Available codecs to decode pictor

```liquidsoap
settings.decoder.ffmpeg.codecs.pictor.available := ["pictor"]
```

##### Preferred codec to decode png

```liquidsoap
settings.decoder.ffmpeg.codecs.png := <value>
```

###### Available codecs to decode png

```liquidsoap
settings.decoder.ffmpeg.codecs.png.available := ["png"]
```

##### Preferred codec to decode ppm

```liquidsoap
settings.decoder.ffmpeg.codecs.ppm := <value>
```

###### Available codecs to decode ppm

```liquidsoap
settings.decoder.ffmpeg.codecs.ppm.available := ["ppm"]
```

##### Preferred codec to decode psd

```liquidsoap
settings.decoder.ffmpeg.codecs.psd := <value>
```

###### Available codecs to decode psd

```liquidsoap
settings.decoder.ffmpeg.codecs.psd.available := ["psd"]
```

##### Preferred codec to decode ptx

```liquidsoap
settings.decoder.ffmpeg.codecs.ptx := <value>
```

###### Available codecs to decode ptx

```liquidsoap
settings.decoder.ffmpeg.codecs.ptx.available := ["ptx"]
```

##### Preferred codec to decode qdm2

```liquidsoap
settings.decoder.ffmpeg.codecs.qdm2 := <value>
```

###### Available codecs to decode qdm2

```liquidsoap
settings.decoder.ffmpeg.codecs.qdm2.available := ["qdm2"]
```

##### Preferred codec to decode qdmc

```liquidsoap
settings.decoder.ffmpeg.codecs.qdmc := <value>
```

###### Available codecs to decode qdmc

```liquidsoap
settings.decoder.ffmpeg.codecs.qdmc.available := ["qdmc"]
```

##### Preferred codec to decode qoi

```liquidsoap
settings.decoder.ffmpeg.codecs.qoi := <value>
```

###### Available codecs to decode qoi

```liquidsoap
settings.decoder.ffmpeg.codecs.qoi.available := ["qoi"]
```

##### Preferred codec to decode qpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.qpeg := <value>
```

###### Available codecs to decode qpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.qpeg.available := ["qpeg"]
```

##### Preferred codec to decode r10k

```liquidsoap
settings.decoder.ffmpeg.codecs.r10k := <value>
```

###### Available codecs to decode r10k

```liquidsoap
settings.decoder.ffmpeg.codecs.r10k.available := ["r10k"]
```

##### Preferred codec to decode r210

```liquidsoap
settings.decoder.ffmpeg.codecs.r210 := <value>
```

###### Available codecs to decode r210

```liquidsoap
settings.decoder.ffmpeg.codecs.r210.available := ["r210"]
```

##### Preferred codec to decode ralf

```liquidsoap
settings.decoder.ffmpeg.codecs.ralf := <value>
```

###### Available codecs to decode ralf

```liquidsoap
settings.decoder.ffmpeg.codecs.ralf.available := ["ralf"]
```

##### Preferred codec to decode rasc

```liquidsoap
settings.decoder.ffmpeg.codecs.rasc := <value>
```

###### Available codecs to decode rasc

```liquidsoap
settings.decoder.ffmpeg.codecs.rasc.available := ["rasc"]
```

##### Preferred codec to decode rka

```liquidsoap
settings.decoder.ffmpeg.codecs.rka := <value>
```

###### Available codecs to decode rka

```liquidsoap
settings.decoder.ffmpeg.codecs.rka.available := ["rka"]
```

##### Preferred codec to decode rl2

```liquidsoap
settings.decoder.ffmpeg.codecs.rl2 := <value>
```

###### Available codecs to decode rl2

```liquidsoap
settings.decoder.ffmpeg.codecs.rl2.available := ["rl2"]
```

##### Preferred codec to decode roq

```liquidsoap
settings.decoder.ffmpeg.codecs.roq := <value>
```

###### Available codecs to decode roq

```liquidsoap
settings.decoder.ffmpeg.codecs.roq.available := ["roqvideo"]
```

##### Preferred codec to decode rpza

```liquidsoap
settings.decoder.ffmpeg.codecs.rpza := <value>
```

###### Available codecs to decode rpza

```liquidsoap
settings.decoder.ffmpeg.codecs.rpza.available := ["rpza"]
```

##### Preferred codec to decode rscc

```liquidsoap
settings.decoder.ffmpeg.codecs.rscc := <value>
```

###### Available codecs to decode rscc

```liquidsoap
settings.decoder.ffmpeg.codecs.rscc.available := ["rscc"]
```

##### Preferred codec to decode rv10

```liquidsoap
settings.decoder.ffmpeg.codecs.rv10 := <value>
```

###### Available codecs to decode rv10

```liquidsoap
settings.decoder.ffmpeg.codecs.rv10.available := ["rv10"]
```

##### Preferred codec to decode rv20

```liquidsoap
settings.decoder.ffmpeg.codecs.rv20 := <value>
```

###### Available codecs to decode rv20

```liquidsoap
settings.decoder.ffmpeg.codecs.rv20.available := ["rv20"]
```

##### Preferred codec to decode rv30

```liquidsoap
settings.decoder.ffmpeg.codecs.rv30 := <value>
```

###### Available codecs to decode rv30

```liquidsoap
settings.decoder.ffmpeg.codecs.rv30.available := ["rv30"]
```

##### Preferred codec to decode rv40

```liquidsoap
settings.decoder.ffmpeg.codecs.rv40 := <value>
```

###### Available codecs to decode rv40

```liquidsoap
settings.decoder.ffmpeg.codecs.rv40.available := ["rv40"]
```

##### Preferred codec to decode sanm

```liquidsoap
settings.decoder.ffmpeg.codecs.sanm := <value>
```

###### Available codecs to decode sanm

```liquidsoap
settings.decoder.ffmpeg.codecs.sanm.available := ["sanm"]
```

##### Preferred codec to decode sbc

```liquidsoap
settings.decoder.ffmpeg.codecs.sbc := <value>
```

###### Available codecs to decode sbc

```liquidsoap
settings.decoder.ffmpeg.codecs.sbc.available := ["sbc"]
```

##### Preferred codec to decode scpr

```liquidsoap
settings.decoder.ffmpeg.codecs.scpr := <value>
```

###### Available codecs to decode scpr

```liquidsoap
settings.decoder.ffmpeg.codecs.scpr.available := ["scpr"]
```

##### Preferred codec to decode screenpresso

```liquidsoap
settings.decoder.ffmpeg.codecs.screenpresso := <value>
```

###### Available codecs to decode screenpresso

```liquidsoap
settings.decoder.ffmpeg.codecs.screenpresso.available := ["screenpresso"]
```

##### Preferred codec to decode sdx2_dpcm

```liquidsoap
settings.decoder.ffmpeg.codecs.sdx2_dpcm := <value>
```

###### Available codecs to decode sdx2_dpcm

```liquidsoap
settings.decoder.ffmpeg.codecs.sdx2_dpcm.available := ["sdx2_dpcm"]
```

##### Preferred codec to decode sgi

```liquidsoap
settings.decoder.ffmpeg.codecs.sgi := <value>
```

###### Available codecs to decode sgi

```liquidsoap
settings.decoder.ffmpeg.codecs.sgi.available := ["sgi"]
```

##### Preferred codec to decode simbiosis_imx

```liquidsoap
settings.decoder.ffmpeg.codecs.simbiosis_imx := <value>
```

###### Available codecs to decode simbiosis_imx

```liquidsoap
settings.decoder.ffmpeg.codecs.simbiosis_imx.available := ["simbiosis_imx"]
```

##### Preferred codec to decode sipr

```liquidsoap
settings.decoder.ffmpeg.codecs.sipr := <value>
```

###### Available codecs to decode sipr

```liquidsoap
settings.decoder.ffmpeg.codecs.sipr.available := ["sipr"]
```

##### Preferred codec to decode siren

```liquidsoap
settings.decoder.ffmpeg.codecs.siren := <value>
```

###### Available codecs to decode siren

```liquidsoap
settings.decoder.ffmpeg.codecs.siren.available := ["siren"]
```

##### Preferred codec to decode smc

```liquidsoap
settings.decoder.ffmpeg.codecs.smc := <value>
```

###### Available codecs to decode smc

```liquidsoap
settings.decoder.ffmpeg.codecs.smc.available := ["smc"]
```

##### Preferred codec to decode snow

```liquidsoap
settings.decoder.ffmpeg.codecs.snow := <value>
```

###### Available codecs to decode snow

```liquidsoap
settings.decoder.ffmpeg.codecs.snow.available := ["snow"]
```

##### Preferred codec to decode sol_dpcm

```liquidsoap
settings.decoder.ffmpeg.codecs.sol_dpcm := <value>
```

###### Available codecs to decode sol_dpcm

```liquidsoap
settings.decoder.ffmpeg.codecs.sol_dpcm.available := ["sol_dpcm"]
```

##### Preferred codec to decode sonic

```liquidsoap
settings.decoder.ffmpeg.codecs.sonic := <value>
```

###### Available codecs to decode sonic

```liquidsoap
settings.decoder.ffmpeg.codecs.sonic.available := ["sonic"]
```

##### Preferred codec to decode sp5x

```liquidsoap
settings.decoder.ffmpeg.codecs.sp5x := <value>
```

###### Available codecs to decode sp5x

```liquidsoap
settings.decoder.ffmpeg.codecs.sp5x.available := ["sp5x"]
```

##### Preferred codec to decode speedhq

```liquidsoap
settings.decoder.ffmpeg.codecs.speedhq := <value>
```

###### Available codecs to decode speedhq

```liquidsoap
settings.decoder.ffmpeg.codecs.speedhq.available := ["speedhq"]
```

##### Preferred codec to decode speex

```liquidsoap
settings.decoder.ffmpeg.codecs.speex := <value>
```

###### Available codecs to decode speex

```liquidsoap
settings.decoder.ffmpeg.codecs.speex.available := ["speex", "libspeex"]
```

##### Preferred codec to decode srgc

```liquidsoap
settings.decoder.ffmpeg.codecs.srgc := <value>
```

###### Available codecs to decode srgc

```liquidsoap
settings.decoder.ffmpeg.codecs.srgc.available := ["srgc"]
```

##### Preferred codec to decode svg

```liquidsoap
settings.decoder.ffmpeg.codecs.svg := <value>
```

###### Available codecs to decode svg

```liquidsoap
settings.decoder.ffmpeg.codecs.svg.available := ["librsvg"]
```

##### Preferred codec to decode svq1

```liquidsoap
settings.decoder.ffmpeg.codecs.svq1 := <value>
```

###### Available codecs to decode svq1

```liquidsoap
settings.decoder.ffmpeg.codecs.svq1.available := ["svq1"]
```

##### Preferred codec to decode svq3

```liquidsoap
settings.decoder.ffmpeg.codecs.svq3 := <value>
```

###### Available codecs to decode svq3

```liquidsoap
settings.decoder.ffmpeg.codecs.svq3.available := ["svq3"]
```

##### Preferred codec to decode tak

```liquidsoap
settings.decoder.ffmpeg.codecs.tak := <value>
```

###### Available codecs to decode tak

```liquidsoap
settings.decoder.ffmpeg.codecs.tak.available := ["tak"]
```

##### Preferred codec to decode targa

```liquidsoap
settings.decoder.ffmpeg.codecs.targa := <value>
```

###### Available codecs to decode targa

```liquidsoap
settings.decoder.ffmpeg.codecs.targa.available := ["targa"]
```

##### Preferred codec to decode targa_y216

```liquidsoap
settings.decoder.ffmpeg.codecs.targa_y216 := <value>
```

###### Available codecs to decode targa_y216

```liquidsoap
settings.decoder.ffmpeg.codecs.targa_y216.available := ["targa_y216"]
```

##### Preferred codec to decode tdsc

```liquidsoap
settings.decoder.ffmpeg.codecs.tdsc := <value>
```

###### Available codecs to decode tdsc

```liquidsoap
settings.decoder.ffmpeg.codecs.tdsc.available := ["tdsc"]
```

##### Preferred codec to decode tgq

```liquidsoap
settings.decoder.ffmpeg.codecs.tgq := <value>
```

###### Available codecs to decode tgq

```liquidsoap
settings.decoder.ffmpeg.codecs.tgq.available := ["eatgq"]
```

##### Preferred codec to decode tgv

```liquidsoap
settings.decoder.ffmpeg.codecs.tgv := <value>
```

###### Available codecs to decode tgv

```liquidsoap
settings.decoder.ffmpeg.codecs.tgv.available := ["eatgv"]
```

##### Preferred codec to decode theora

```liquidsoap
settings.decoder.ffmpeg.codecs.theora := <value>
```

###### Available codecs to decode theora

```liquidsoap
settings.decoder.ffmpeg.codecs.theora.available := ["theora"]
```

##### Preferred codec to decode thp

```liquidsoap
settings.decoder.ffmpeg.codecs.thp := <value>
```

###### Available codecs to decode thp

```liquidsoap
settings.decoder.ffmpeg.codecs.thp.available := ["thp"]
```

##### Preferred codec to decode tiertexseqvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.tiertexseqvideo := <value>
```

###### Available codecs to decode tiertexseqvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.tiertexseqvideo.available := ["tiertexseqvideo"]
```

##### Preferred codec to decode tiff

```liquidsoap
settings.decoder.ffmpeg.codecs.tiff := <value>
```

###### Available codecs to decode tiff

```liquidsoap
settings.decoder.ffmpeg.codecs.tiff.available := ["tiff"]
```

##### Preferred codec to decode tmv

```liquidsoap
settings.decoder.ffmpeg.codecs.tmv := <value>
```

###### Available codecs to decode tmv

```liquidsoap
settings.decoder.ffmpeg.codecs.tmv.available := ["tmv"]
```

##### Preferred codec to decode tqi

```liquidsoap
settings.decoder.ffmpeg.codecs.tqi := <value>
```

###### Available codecs to decode tqi

```liquidsoap
settings.decoder.ffmpeg.codecs.tqi.available := ["eatqi"]
```

##### Preferred codec to decode truehd

```liquidsoap
settings.decoder.ffmpeg.codecs.truehd := <value>
```

###### Available codecs to decode truehd

```liquidsoap
settings.decoder.ffmpeg.codecs.truehd.available := ["truehd"]
```

##### Preferred codec to decode truemotion1

```liquidsoap
settings.decoder.ffmpeg.codecs.truemotion1 := <value>
```

###### Available codecs to decode truemotion1

```liquidsoap
settings.decoder.ffmpeg.codecs.truemotion1.available := ["truemotion1"]
```

##### Preferred codec to decode truemotion2

```liquidsoap
settings.decoder.ffmpeg.codecs.truemotion2 := <value>
```

###### Available codecs to decode truemotion2

```liquidsoap
settings.decoder.ffmpeg.codecs.truemotion2.available := ["truemotion2"]
```

##### Preferred codec to decode truemotion2rt

```liquidsoap
settings.decoder.ffmpeg.codecs.truemotion2rt := <value>
```

###### Available codecs to decode truemotion2rt

```liquidsoap
settings.decoder.ffmpeg.codecs.truemotion2rt.available := ["truemotion2rt"]
```

##### Preferred codec to decode tscc

```liquidsoap
settings.decoder.ffmpeg.codecs.tscc := <value>
```

###### Available codecs to decode tscc

```liquidsoap
settings.decoder.ffmpeg.codecs.tscc.available := ["camtasia"]
```

##### Preferred codec to decode tscc2

```liquidsoap
settings.decoder.ffmpeg.codecs.tscc2 := <value>
```

###### Available codecs to decode tscc2

```liquidsoap
settings.decoder.ffmpeg.codecs.tscc2.available := ["tscc2"]
```

##### Preferred codec to decode tta

```liquidsoap
settings.decoder.ffmpeg.codecs.tta := <value>
```

###### Available codecs to decode tta

```liquidsoap
settings.decoder.ffmpeg.codecs.tta.available := ["tta"]
```

##### Preferred codec to decode txd

```liquidsoap
settings.decoder.ffmpeg.codecs.txd := <value>
```

###### Available codecs to decode txd

```liquidsoap
settings.decoder.ffmpeg.codecs.txd.available := ["txd"]
```

##### Preferred codec to decode ulti

```liquidsoap
settings.decoder.ffmpeg.codecs.ulti := <value>
```

###### Available codecs to decode ulti

```liquidsoap
settings.decoder.ffmpeg.codecs.ulti.available := ["ultimotion"]
```

##### Preferred codec to decode v210

```liquidsoap
settings.decoder.ffmpeg.codecs.v210 := <value>
```

###### Available codecs to decode v210

```liquidsoap
settings.decoder.ffmpeg.codecs.v210.available := ["v210"]
```

##### Preferred codec to decode v210x

```liquidsoap
settings.decoder.ffmpeg.codecs.v210x := <value>
```

###### Available codecs to decode v210x

```liquidsoap
settings.decoder.ffmpeg.codecs.v210x.available := ["v210x"]
```

##### Preferred codec to decode v308

```liquidsoap
settings.decoder.ffmpeg.codecs.v308 := <value>
```

###### Available codecs to decode v308

```liquidsoap
settings.decoder.ffmpeg.codecs.v308.available := ["v308"]
```

##### Preferred codec to decode v408

```liquidsoap
settings.decoder.ffmpeg.codecs.v408 := <value>
```

###### Available codecs to decode v408

```liquidsoap
settings.decoder.ffmpeg.codecs.v408.available := ["v408"]
```

##### Preferred codec to decode v410

```liquidsoap
settings.decoder.ffmpeg.codecs.v410 := <value>
```

###### Available codecs to decode v410

```liquidsoap
settings.decoder.ffmpeg.codecs.v410.available := ["v410"]
```

##### Preferred codec to decode vb

```liquidsoap
settings.decoder.ffmpeg.codecs.vb := <value>
```

###### Available codecs to decode vb

```liquidsoap
settings.decoder.ffmpeg.codecs.vb.available := ["vb"]
```

##### Preferred codec to decode vble

```liquidsoap
settings.decoder.ffmpeg.codecs.vble := <value>
```

###### Available codecs to decode vble

```liquidsoap
settings.decoder.ffmpeg.codecs.vble.available := ["vble"]
```

##### Preferred codec to decode vbn

```liquidsoap
settings.decoder.ffmpeg.codecs.vbn := <value>
```

###### Available codecs to decode vbn

```liquidsoap
settings.decoder.ffmpeg.codecs.vbn.available := ["vbn"]
```

##### Preferred codec to decode vc1

```liquidsoap
settings.decoder.ffmpeg.codecs.vc1 := <value>
```

###### Available codecs to decode vc1

```liquidsoap
settings.decoder.ffmpeg.codecs.vc1.available := ["vc1", "vc1_v4l2m2m", "vc1_cuvid"]
```

##### Preferred codec to decode vc1image

```liquidsoap
settings.decoder.ffmpeg.codecs.vc1image := <value>
```

###### Available codecs to decode vc1image

```liquidsoap
settings.decoder.ffmpeg.codecs.vc1image.available := ["vc1image"]
```

##### Preferred codec to decode vcr1

```liquidsoap
settings.decoder.ffmpeg.codecs.vcr1 := <value>
```

###### Available codecs to decode vcr1

```liquidsoap
settings.decoder.ffmpeg.codecs.vcr1.available := ["vcr1"]
```

##### Preferred codec to decode vixl

```liquidsoap
settings.decoder.ffmpeg.codecs.vixl := <value>
```

###### Available codecs to decode vixl

```liquidsoap
settings.decoder.ffmpeg.codecs.vixl.available := ["xl"]
```

##### Preferred codec to decode vmdaudio

```liquidsoap
settings.decoder.ffmpeg.codecs.vmdaudio := <value>
```

###### Available codecs to decode vmdaudio

```liquidsoap
settings.decoder.ffmpeg.codecs.vmdaudio.available := ["vmdaudio"]
```

##### Preferred codec to decode vmdvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.vmdvideo := <value>
```

###### Available codecs to decode vmdvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.vmdvideo.available := ["vmdvideo"]
```

##### Preferred codec to decode vmnc

```liquidsoap
settings.decoder.ffmpeg.codecs.vmnc := <value>
```

###### Available codecs to decode vmnc

```liquidsoap
settings.decoder.ffmpeg.codecs.vmnc.available := ["vmnc"]
```

##### Preferred codec to decode vorbis

```liquidsoap
settings.decoder.ffmpeg.codecs.vorbis := <value>
```

###### Available codecs to decode vorbis

```liquidsoap
settings.decoder.ffmpeg.codecs.vorbis.available := ["vorbis", "libvorbis"]
```

##### Preferred codec to decode vp3

```liquidsoap
settings.decoder.ffmpeg.codecs.vp3 := <value>
```

###### Available codecs to decode vp3

```liquidsoap
settings.decoder.ffmpeg.codecs.vp3.available := ["vp3"]
```

##### Preferred codec to decode vp4

```liquidsoap
settings.decoder.ffmpeg.codecs.vp4 := <value>
```

###### Available codecs to decode vp4

```liquidsoap
settings.decoder.ffmpeg.codecs.vp4.available := ["vp4"]
```

##### Preferred codec to decode vp5

```liquidsoap
settings.decoder.ffmpeg.codecs.vp5 := <value>
```

###### Available codecs to decode vp5

```liquidsoap
settings.decoder.ffmpeg.codecs.vp5.available := ["vp5"]
```

##### Preferred codec to decode vp6

```liquidsoap
settings.decoder.ffmpeg.codecs.vp6 := <value>
```

###### Available codecs to decode vp6

```liquidsoap
settings.decoder.ffmpeg.codecs.vp6.available := ["vp6"]
```

##### Preferred codec to decode vp6a

```liquidsoap
settings.decoder.ffmpeg.codecs.vp6a := <value>
```

###### Available codecs to decode vp6a

```liquidsoap
settings.decoder.ffmpeg.codecs.vp6a.available := ["vp6a"]
```

##### Preferred codec to decode vp6f

```liquidsoap
settings.decoder.ffmpeg.codecs.vp6f := <value>
```

###### Available codecs to decode vp6f

```liquidsoap
settings.decoder.ffmpeg.codecs.vp6f.available := ["vp6f"]
```

##### Preferred codec to decode vp7

```liquidsoap
settings.decoder.ffmpeg.codecs.vp7 := <value>
```

###### Available codecs to decode vp7

```liquidsoap
settings.decoder.ffmpeg.codecs.vp7.available := ["vp7"]
```

##### Preferred codec to decode vp8

```liquidsoap
settings.decoder.ffmpeg.codecs.vp8 := <value>
```

###### Available codecs to decode vp8

```liquidsoap
settings.decoder.ffmpeg.codecs.vp8.available := ["vp8", "vp8_v4l2m2m", "libvpx", "vp8_cuvid"]
```

##### Preferred codec to decode vp9

```liquidsoap
settings.decoder.ffmpeg.codecs.vp9 := <value>
```

###### Available codecs to decode vp9

```liquidsoap
settings.decoder.ffmpeg.codecs.vp9.available := ["vp9", "vp9_v4l2m2m", "libvpx-vp9", "vp9_cuvid"]
```

##### Preferred codec to decode vqc

```liquidsoap
settings.decoder.ffmpeg.codecs.vqc := <value>
```

###### Available codecs to decode vqc

```liquidsoap
settings.decoder.ffmpeg.codecs.vqc.available := ["vqc"]
```

##### Preferred codec to decode wavesynth

```liquidsoap
settings.decoder.ffmpeg.codecs.wavesynth := <value>
```

###### Available codecs to decode wavesynth

```liquidsoap
settings.decoder.ffmpeg.codecs.wavesynth.available := ["wavesynth"]
```

##### Preferred codec to decode wavpack

```liquidsoap
settings.decoder.ffmpeg.codecs.wavpack := <value>
```

###### Available codecs to decode wavpack

```liquidsoap
settings.decoder.ffmpeg.codecs.wavpack.available := ["wavpack"]
```

##### Preferred codec to decode wbmp

```liquidsoap
settings.decoder.ffmpeg.codecs.wbmp := <value>
```

###### Available codecs to decode wbmp

```liquidsoap
settings.decoder.ffmpeg.codecs.wbmp.available := ["wbmp"]
```

##### Preferred codec to decode wcmv

```liquidsoap
settings.decoder.ffmpeg.codecs.wcmv := <value>
```

###### Available codecs to decode wcmv

```liquidsoap
settings.decoder.ffmpeg.codecs.wcmv.available := ["wcmv"]
```

##### Preferred codec to decode webp

```liquidsoap
settings.decoder.ffmpeg.codecs.webp := <value>
```

###### Available codecs to decode webp

```liquidsoap
settings.decoder.ffmpeg.codecs.webp.available := ["webp"]
```

##### Preferred codec to decode westwood_snd1

```liquidsoap
settings.decoder.ffmpeg.codecs.westwood_snd1 := <value>
```

###### Available codecs to decode westwood_snd1

```liquidsoap
settings.decoder.ffmpeg.codecs.westwood_snd1.available := ["ws_snd1"]
```

##### Preferred codec to decode wmalossless

```liquidsoap
settings.decoder.ffmpeg.codecs.wmalossless := <value>
```

###### Available codecs to decode wmalossless

```liquidsoap
settings.decoder.ffmpeg.codecs.wmalossless.available := ["wmalossless"]
```

##### Preferred codec to decode wmavoice

```liquidsoap
settings.decoder.ffmpeg.codecs.wmavoice := <value>
```

###### Available codecs to decode wmavoice

```liquidsoap
settings.decoder.ffmpeg.codecs.wmavoice.available := ["wmavoice"]
```

##### Preferred codec to decode wmv1

```liquidsoap
settings.decoder.ffmpeg.codecs.wmv1 := <value>
```

###### Available codecs to decode wmv1

```liquidsoap
settings.decoder.ffmpeg.codecs.wmv1.available := ["wmv1"]
```

##### Preferred codec to decode wmv2

```liquidsoap
settings.decoder.ffmpeg.codecs.wmv2 := <value>
```

###### Available codecs to decode wmv2

```liquidsoap
settings.decoder.ffmpeg.codecs.wmv2.available := ["wmv2"]
```

##### Preferred codec to decode wmv3

```liquidsoap
settings.decoder.ffmpeg.codecs.wmv3 := <value>
```

###### Available codecs to decode wmv3

```liquidsoap
settings.decoder.ffmpeg.codecs.wmv3.available := ["wmv3"]
```

##### Preferred codec to decode wnv1

```liquidsoap
settings.decoder.ffmpeg.codecs.wnv1 := <value>
```

###### Available codecs to decode wnv1

```liquidsoap
settings.decoder.ffmpeg.codecs.wnv1.available := ["wnv1"]
```

##### Preferred codec to decode ws_vqa

```liquidsoap
settings.decoder.ffmpeg.codecs.ws_vqa := <value>
```

###### Available codecs to decode ws_vqa

```liquidsoap
settings.decoder.ffmpeg.codecs.ws_vqa.available := ["vqavideo"]
```

##### Preferred codec to decode xan_wc3

```liquidsoap
settings.decoder.ffmpeg.codecs.xan_wc3 := <value>
```

###### Available codecs to decode xan_wc3

```liquidsoap
settings.decoder.ffmpeg.codecs.xan_wc3.available := ["xan_wc3"]
```

##### Preferred codec to decode xan_wc4

```liquidsoap
settings.decoder.ffmpeg.codecs.xan_wc4 := <value>
```

###### Available codecs to decode xan_wc4

```liquidsoap
settings.decoder.ffmpeg.codecs.xan_wc4.available := ["xan_wc4"]
```

##### Preferred codec to decode xbm

```liquidsoap
settings.decoder.ffmpeg.codecs.xbm := <value>
```

###### Available codecs to decode xbm

```liquidsoap
settings.decoder.ffmpeg.codecs.xbm.available := ["xbm"]
```

##### Preferred codec to decode xma1

```liquidsoap
settings.decoder.ffmpeg.codecs.xma1 := <value>
```

###### Available codecs to decode xma1

```liquidsoap
settings.decoder.ffmpeg.codecs.xma1.available := ["xma1"]
```

##### Preferred codec to decode xma2

```liquidsoap
settings.decoder.ffmpeg.codecs.xma2 := <value>
```

###### Available codecs to decode xma2

```liquidsoap
settings.decoder.ffmpeg.codecs.xma2.available := ["xma2"]
```

##### Preferred codec to decode xpm

```liquidsoap
settings.decoder.ffmpeg.codecs.xpm := <value>
```

###### Available codecs to decode xpm

```liquidsoap
settings.decoder.ffmpeg.codecs.xpm.available := ["xpm"]
```

##### Preferred codec to decode xwd

```liquidsoap
settings.decoder.ffmpeg.codecs.xwd := <value>
```

###### Available codecs to decode xwd

```liquidsoap
settings.decoder.ffmpeg.codecs.xwd.available := ["xwd"]
```

##### Preferred codec to decode y41p

```liquidsoap
settings.decoder.ffmpeg.codecs.y41p := <value>
```

###### Available codecs to decode y41p

```liquidsoap
settings.decoder.ffmpeg.codecs.y41p.available := ["y41p"]
```

##### Preferred codec to decode ylc

```liquidsoap
settings.decoder.ffmpeg.codecs.ylc := <value>
```

###### Available codecs to decode ylc

```liquidsoap
settings.decoder.ffmpeg.codecs.ylc.available := ["ylc"]
```

##### Preferred codec to decode yop

```liquidsoap
settings.decoder.ffmpeg.codecs.yop := <value>
```

###### Available codecs to decode yop

```liquidsoap
settings.decoder.ffmpeg.codecs.yop.available := ["yop"]
```

##### Preferred codec to decode yuv4

```liquidsoap
settings.decoder.ffmpeg.codecs.yuv4 := <value>
```

###### Available codecs to decode yuv4

```liquidsoap
settings.decoder.ffmpeg.codecs.yuv4.available := ["yuv4"]
```

##### Preferred codec to decode zlib

```liquidsoap
settings.decoder.ffmpeg.codecs.zlib := <value>
```

###### Available codecs to decode zlib

```liquidsoap
settings.decoder.ffmpeg.codecs.zlib.available := ["zlib"]
```

##### Preferred codec to decode zmbv

```liquidsoap
settings.decoder.ffmpeg.codecs.zmbv := <value>
```

###### Available codecs to decode zmbv

```liquidsoap
settings.decoder.ffmpeg.codecs.zmbv.available := ["zmbv"]
```

#### Maximum delay between interleaved streams.

```liquidsoap
settings.decoder.ffmpeg.max_interleave_delta := 0.04
```

#### Maximum data buffered while waiting for all streams.

```liquidsoap
settings.decoder.ffmpeg.max_interleave_duration := 5.0
```

### File extensions used for guessing audio formats

#### File extensions used for guessing AAC format

```liquidsoap
settings.decoder.file_extensions.aac := ["aac"]
```

#### File extensions used for guessing AIFF format

```liquidsoap
settings.decoder.file_extensions.aiff := ["aiff", "aif", "aifc"]
```

#### File extensions used for decoding media files (except images) with ffmpeg

```liquidsoap
settings.decoder.file_extensions.ffmpeg := ["264", "265", "302", "3g2", "3gp", "669", "722", "A64", "a64", "aa", "aa3", "aac", "aax", "ac3", "acm", "adf", "adp", "ads", "adts", "adx", "aea", "afc", "aif", "aifc", "aiff", "aix", "amf", "amr", "ams", "amv", "ape", "apl", "apm", "apng", "aptx", "aptxhd", "aqt", "asf", "ass", "ast", "au", "aud", "avi", "avr", "avs", "avs2", "bcstm", "bfstm", "binka", "bit", "bmv", "brstm", "c2", "calf", "cavs", "cdata", "cdg", "cdxl", "cgi", "chk", "cif", "cpk", "cvg", "dat", "daud", "dav", "dbm", "dif", "digi", "dmf", "dnxhd", "dnxhr", "drc", "dsm", "dss", "dtk", "dtm", "dts", "dtshd", "dv", "dvd", "eac3", "f4v", "fap", "far", "ffmeta", "fits", "flac", "flm", "flv", "fsb", "fwse", "g722", "g723_1", "g729", "gdm", "genh", "gif", "gsm", "gxf", "h261", "h263", "h264", "h265", "hca", "hevc", "ice", "ico", "idf", "idx", "ifv", "imf", "imx", "ipu", "ircam", "ism", "isma", "ismv", "it", "ivf", "ivr", "j2b", "jss", "kux", "latm", "lbc", "loas", "lrc", "lvf", "m15", "m1v", "m2a", "m2t", "m2ts", "m2v", "m3u8", "m4a", "m4b", "m4v", "mac", "mca", "mcc", "mdl", "med", "mj2", "mjpeg", "mjpg", "mk3d", "mka", "mks", "mkv", "mlp", "mmcmp", "mmf", "mms", "mo3", "mod", "mods", "moflex", "mov", "mp2", "mp3", "mp4", "mpa", "mpc", "mpd", "mpeg", "mpg", "mpl2", "mptm", "msbc", "msf", "mt2", "mtaf", "mtm", "mts", "musx", "mvi", "mxf", "mxg", "nist", "nsp", "nst", "nut", "obu", "oga", "ogg", "ogv", "okt", "oma", "omg", "opus", "paf", "pcm", "pjs", "plm", "psm", "psp", "pt36", "ptm", "pvf", "qcif", "ra", "rco", "rcv", "rgb", "rm", "roq", "rsd", "rso", "rt", "s3m", "sami", "sbc", "sbg", "scc", "sdr2", "sds", "sdx", "ser", "sf", "sfx", "sfx2", "sga", "shn", "sln", "smi", "son", "sox", "spdif", "sph", "spx", "srt", "ss2", "ssa", "st26", "stk", "stl", "stm", "stp", "str", "sub", "sup", "svag", "svs", "swf", "tak", "tco", "thd", "ts", "tta", "ttml", "tun", "txt", "ty", "ty+", "ult", "umx", "v", "v210", "vag", "vb", "vc1", "vc2", "viv", "vob", "voc", "vpk", "vqe", "vqf", "vql", "vtt", "w64", "wav", "webm", "wma", "wmv", "wow", "wsd", "wtv", "wv", "xl", "xm", "xml", "xmv", "xpk", "xvag", "y4m", "yop", "yuv"]
```

##### File extensions used for decoding images with ffmpeg

```liquidsoap
settings.decoder.file_extensions.ffmpeg.images := ["bmp", "cri", "dds", "dng", "dpx", "exr", "im1", "im24", "im32", "im8", "j2c", "j2k", "jls", "jp2", "jpc", "jpeg", "jpg", "jps", "ljpg", "mng", "mpg1-img", "mpg2-img", "mpg4-img", "mpo", "pam", "pbm", "pcd", "pct", "pcx", "pfm", "pgm", "pgmyuv", "pic", "pict", "pix", "png", "pnm", "pns", "ppm", "ptx", "ras", "raw", "rs", "sgi", "sun", "sunras", "svg", "svgz", "tga", "tif", "tiff", "webp", "xbm", "xface", "xpm", "xwd", "y", "yuv10"]
```

#### File extensions used for guessing FLAC format

```liquidsoap
settings.decoder.file_extensions.flac := ["flac"]
```

#### File extensions used for decoding metadata using native FLAC parser.

```liquidsoap
settings.decoder.file_extensions.flac_metadata := ["flac"]
```

#### File extensions used for decoding metadata using native ID3v1 and ID3v2 parser

```liquidsoap
settings.decoder.file_extensions.id3 := ["mp3", "wav"]
```

#### File extensions used for decoding metadata using native parser.

```liquidsoap
settings.decoder.file_extensions.image_metadata := ["png", "jpg", "jpeg"]
```

#### File extensions used for guessing mpeg audio format

```liquidsoap
settings.decoder.file_extensions.mad := ["mp3", "mp2", "mp1"]
```

#### File extensions used for guessing MP3 format (DEPRECATED, use *.mad configuration keys!)

```liquidsoap
settings.decoder.file_extensions.mp3 := ["mp3", "mp2", "mp1"]
```

#### File extensions used for guessing MP4 format

```liquidsoap
settings.decoder.file_extensions.mp4 := ["m4a", "m4b", "m4p", "m4v", "m4r", "3gp", "mp4"]
```

#### File extensions used for guessing OGG format

```liquidsoap
settings.decoder.file_extensions.ogg := ["ogv", "oga", "ogx", "ogg", "opus"]
```

#### File extensions used for decoding metadata using native ogg parser.

```liquidsoap
settings.decoder.file_extensions.ogg_metadata := ["ogg"]
```

#### File extensions used for guessing SRT format

```liquidsoap
settings.decoder.file_extensions.srt := ["srt"]
```

#### File extensions used for decoding metadata using native parser.

```liquidsoap
settings.decoder.file_extensions.video_metadata := ["avi", "mp4"]
```

#### File extensions used for guessing WAV format

```liquidsoap
settings.decoder.file_extensions.wav := ["wav", "wave"]
```

### Native FLAC metadata parser settings.

#### Separator used to join metadata field with several entries.

```liquidsoap
settings.decoder.flac_metadata.separator := ", "
```

### Native ID3 parser settings

### Decoders and order used to decode image files.

```liquidsoap
settings.decoder.image_file_decoders := ["ppm", "ffmpeg", "sdl"]
```

### Native image metadata parser settings.

### Mime-types used for choosing audio and video file decoders

When a mime-type is available (e.g. with input.http), it can be used to guess which audio stream format is used.This section contains the listings used for that detection, which you might want to tweak if you encounter a new mime-type.If you feel that new mime-types should be permanently added, please contact the developers.

#### Mime-types used for guessing AAC format

```liquidsoap
settings.decoder.mime_types.aac := ["audio/aac", "audio/aacp", "audio/x-hx-aac-adts"]
```

#### Mime-types used for guessing AIFF format

```liquidsoap
settings.decoder.mime_types.aiff := ["audio/x-aiff", "audio/aiff"]
```

#### Mime-types used for guessing PCM/BASIC format

```liquidsoap
settings.decoder.mime_types.basic := ["audio/basic"]
```

#### Mime-types used for decoding with ffmpeg

```liquidsoap
settings.decoder.mime_types.ffmpeg := ["application/f4v", "application/ffmpeg", "application/mp4", "application/mxf", "application/octet-stream", "application/octet-stream", "application/ogg", "application/vnd.pg.format", "application/vnd.rn-realmedia", "application/vnd.smaf", "application/x-mpegURL", "application/x-ogg", "application/x-pgs", "application/x-shockwave-flash", "application/x-subrip", "application/xml", "audio/G722", "audio/MP4A-LATM", "audio/MPA", "audio/aac", "audio/aacp", "audio/aiff", "audio/amr", "audio/basic", "audio/bit", "audio/flac", "audio/g723", "audio/iLBC", "audio/mp4", "audio/mpeg", "audio/ogg", "audio/vnd.wave", "audio/wav", "audio/wave", "audio/webm", "audio/x-ac3", "audio/x-adpcm", "audio/x-caf", "audio/x-dca", "audio/x-eac3", "audio/x-flac", "audio/x-gsm", "audio/x-hx-aac-adts", "audio/x-ogg", "audio/x-oma", "audio/x-tta", "audio/x-voc", "audio/x-wav", "audio/x-wavpack", "multipart/x-mixed-replace;boundary=ffserver", "text/vtt", "text/x-ass", "text/x-jacosub", "text/x-microdvd", "video/3gpp", "video/3gpp2", "video/MP2T", "video/mp2t", "video/mp4", "video/mpeg", "video/ogg", "video/webm", "video/x-flv", "video/x-h261", "video/x-h263", "video/x-m4v", "video/x-matroska", "video/x-mjpeg", "video/x-ms-asf", "video/x-msvideo", "video/x-nut"]
```

##### Mime-types used for decoding images with ffmpeg

```liquidsoap
settings.decoder.mime_types.ffmpeg.images := ["image/gif", "image/jpeg", "image/png", "image/vnd.microsoft.icon", "image/webp"]
```

#### Mime-types used for guessing FLAC format

```liquidsoap
settings.decoder.mime_types.flac := ["audio/flac", "audio/x-flac"]
```

#### Mime-types used for decoding metadata using native FLAC metadata parser.

```liquidsoap
settings.decoder.mime_types.flac_metadata := ["audio/flac"]
```

#### Mime-types used for decoding metadata using native ID3v1 and ID3v2 parser

```liquidsoap
settings.decoder.mime_types.id3 := ["audio/mpeg", "audio/x-wav"]
```

#### Mime-types used for decoding metadata using native parser.

```liquidsoap
settings.decoder.mime_types.image_metadata := ["image/png", "image/jpeg"]
```

#### Mime-types used for guessing mpeg audio format

```liquidsoap
settings.decoder.mime_types.mad := ["audio/mpeg", "audio/MPA"]
```

#### Mime-types used for guessing MP3 format (DEPRECATED, use *.mad configuration keys!)

```liquidsoap
settings.decoder.mime_types.mp3 := ["audio/mpeg", "audio/MPA"]
```

#### Mime-types used for guessing MP4 format

```liquidsoap
settings.decoder.mime_types.mp4 := ["audio/mp4", "application/mp4"]
```

#### Mime-types used for guessing OGG format.

```liquidsoap
settings.decoder.mime_types.ogg := ["audio/opus", "application/ogg", "application/x-ogg", "audio/x-ogg", "audio/ogg", "video/ogg"]
```

#### Mime-types used for decoding metadata using native ogg metadata parser.

```liquidsoap
settings.decoder.mime_types.ogg_metadata := ["audio/ogg"]
```

#### Mime-types used for guessing SRT format

```liquidsoap
settings.decoder.mime_types.srt := ["application/x-subrip"]
```

#### Mime-types used for decoding metadata using native parser.

```liquidsoap
settings.decoder.mime_types.video_metadata := ["video/x-msvideo", "video/mp4"]
```

#### Mime-types used for guessing WAV format

```liquidsoap
settings.decoder.mime_types.wav := ["audio/vnd.wave", "audio/wav", "audio/wave", "audio/x-wav"]
```

### Native ogg metadata parser settings.

#### Separator used to join metadata field with several entries.

```liquidsoap
settings.decoder.ogg_metadata.separator := ", "
```

### Priorities used for choosing audio and video file decoders

#### Priority for the AAC decoder

```liquidsoap
settings.decoder.priorities.aac := 1
```

#### Priority for the AIFF decoder

```liquidsoap
settings.decoder.priorities.aiff := 1
```

#### Priority for the PCM/BASIC decoder

```liquidsoap
settings.decoder.priorities.basic := 1
```

#### Priority for the ffmpeg decoder

```liquidsoap
settings.decoder.priorities.ffmpeg := 10
```

#### Priority for the flac decoder

```liquidsoap
settings.decoder.priorities.flac := 1
```

#### Priorities used for choosing image file decoders

##### Priority for the ffmpeg image decoder

```liquidsoap
settings.decoder.priorities.image.ffmpeg := 10
```

##### Priority for the ppm image decoder

```liquidsoap
settings.decoder.priorities.image.ppm := 1
```

##### Priority for the sdl image decoder

```liquidsoap
settings.decoder.priorities.image.sdl := 5
```

#### Priority for the mpeg audio decoder

```liquidsoap
settings.decoder.priorities.mad := 1
```

#### Priority for the MP4 decoder

```liquidsoap
settings.decoder.priorities.mp4 := 1
```

#### Priority for the OGG decoder

```liquidsoap
settings.decoder.priorities.ogg := 15
```

#### Priority for the SRT decoder

```liquidsoap
settings.decoder.priorities.srt := 1
```

#### Priority for the WAV decoder

```liquidsoap
settings.decoder.priorities.wav := 1
```

### Native video metadata parser settings.

## Default font

```liquidsoap
settings.default_font := "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"
```

## Encoder settings

Settings for the encoder

### Metadata settings

Settings for the encoded metadata.

#### Metadata labels that represent coverart

```liquidsoap
settings.encoder.metadata.cover := ["pic", "apic", "metadata_block_picture", "cover"]
```

#### Exported metadata

The list of labels of exported metadata.

```liquidsoap
settings.encoder.metadata.export := ["artist", "title", "album", "genre", "date", "tracknumber", "comment", "track", "year", "dj", "next", "apic", "pic", "metadata_url", "metadata_block_picture", "coverart"]
```

## FFMPEG configuration

### FFmpeg content configuration

#### FFmpeg copy content configuration

##### If `true`, relax content compatibility, e.g. allow audio tracks with different samplerate or video tracks with different resolution.

```liquidsoap
settings.ffmpeg.content.copy.relaxed_compatibility_check := false
```

### Log configuration

#### Level

```liquidsoap
settings.ffmpeg.log.level := 3
```

#### Verbosity

Set FFMPEG log level, one of: "quiet", "panic", "fatal", "error", "warning", "info", "verbose", "debug" or "trace".

```liquidsoap
settings.ffmpeg.log.verbosity := "warning"
```

### Scaling algorithm

Set FFMPEG scaling algorithm. One of: "fast_bilinear","bilinear" or "bicubic".

```liquidsoap
settings.ffmpeg.scaling_algorithm := "bicubic"
```

## Frame format

Settings for the data representation in frames, which are theelementary packets of which streams are made.

### Audio (PCM) format

#### Default number of channels

```liquidsoap
settings.frame.audio.channels := 2
```

#### Samplerate

```liquidsoap
settings.frame.audio.samplerate := 44100
```

#### Tentative frame duration in audio samples

Audio samplerate and video frame rate constrain the possible frame durations.This setting is used as a hint for the duration, overriding'frame.duration'.Tweaking frame duration is tricky but needed when dealing with latencyor getting soundcard I/O correctly synchronized with liquidsoap.

```liquidsoap
settings.frame.audio.size := <value>
```

### Frame duration in seconds

Set frame duration, in seconds.This setting control the latency of the streaming system. When set toa smaller value, latency is reduced at the expense of more dataconsumption. When set to a larger value, CPU and memory usage shouldgo down but latency should increase.Tweaking frame duration is tricky but needed when dealing with latencyor getting soundcard I/O correctly synchronized with liquidsoap.

```liquidsoap
settings.frame.duration := 0.02
```

### MIDI parameters

#### Default number of channels

```liquidsoap
settings.frame.midi.channels := 0
```

### Video settings

#### Set to `true` to force video content even when no video content is explicitly requested, for instance: `output.dummy(noise())`

```liquidsoap
settings.frame.video.default := false
```

#### Frame rate

```liquidsoap
settings.frame.video.framerate := 25
```

#### Image height

```liquidsoap
settings.frame.video.height := 720
```

#### Image width

```liquidsoap
settings.frame.video.width := 1280
```

## Harbor settings (Icecast/shoutcast stream receiver).

### Timeout for network accept operations (in seconds).

```liquidsoap
settings.harbor.accept_timeout := 3.0
```

### IP addresses on which the harbor should listen.

```liquidsoap
settings.harbor.bind_addrs := ["0.0.0.0"]
```

### Content-type (mime) of formats which allow shout metadata update.

```liquidsoap
settings.harbor.icy_formats := ["audio/mpeg", "audio/aacp", "audio/aac", "audio/x-aac", "audio/wav", "audio/wave", "audio/flac", "audio/x-flac"]
```

### If `true`, `"song"` metadata in icecast metadata update is mapped to `"title"` unless on of: `"artist"` or `"title"` metadata is also passed in which case `"song"` metadata is removed as it usually contains redundant info that confuses the system. Metadata are passed as-is when `false`.

```liquidsoap
settings.harbor.map_song_metadata := true
```

### Maximum of pending source requests per port.

```liquidsoap
settings.harbor.max_connections := 128
```

### Perform reverse DNS lookup to get the client's hostname from its IP.

```liquidsoap
settings.harbor.reverse_dns := false
```

### Timeout for network operations (in seconds).

```liquidsoap
settings.harbor.timeout := 120.0
```

### Display passwords, for debugging.

```liquidsoap
settings.harbor.verbose := false
```

## Icecast configuration

### Set preference for resolving addresses. One of: `"system"`, `"ipv4"` or `"ipv6"`.

```liquidsoap
settings.icecast.prefer_address := "system"
```

## Log configuration

### Log to file

```liquidsoap
settings.log.file := false
```

#### Append log to the file

```liquidsoap
settings.log.file.append := true
```

#### Path to log file

```liquidsoap
settings.log.file.path := "<syslogdir>/<script>.log"
```

#### Log file permissions

```liquidsoap
settings.log.file.perms := 384
```

### General log level

```liquidsoap
settings.log.level := 3
```

### Recode log entries. Source encoding is set using `settings.charset.encodings`.

```liquidsoap
settings.log.recode := false
```

#### Encoding to recode log entries to.

```liquidsoap
settings.log.recode.encoding := "UTF-8"
```

### Log to stdout

```liquidsoap
settings.log.stdout := true
```

### Display unix timestamps (subsecond accuracy, timezone independent)

```liquidsoap
settings.log.unix_timestamps := false
```

## Parameters for the mpd protocol.

### Debug communications with MPD server.

```liquidsoap
settings.mpd.debug := false
```

### MPD host.

```liquidsoap
settings.mpd.host := "127.0.0.1"
```

### Directory where MPD's music is located.

```liquidsoap
settings.mpd.path := "/var/lib/mpd/music"
```

### MPD port.

```liquidsoap
settings.mpd.port := 6600
```

### Randomize order of MPD's results.

```liquidsoap
settings.mpd.randomize := true
```

## Interactions through the OSC protocol.

### Port for OSC server.

```liquidsoap
settings.osc.port := 7777
```

## Interactions through the OSC protocol.

### Port for OSC server.

```liquidsoap
settings.oscnative.port := 7777
```

## Metric reporting using prometheus.

### Enable the prometheus server.

```liquidsoap
settings.prometheus.server := false
```

#### Port to run the server on.

```liquidsoap
settings.prometheus.server.port := 9599
```

## Requests configuration

### DEPRECATED: Add `on_air` and `on_air_timestamp` request metadata.

`on_air` and `on_air_timestamp` are DEPRECATED! Requests can be used inmultiple sources and/or outputs. Its recommended to use output's`on_track` method to track the latest metadata currently being playedby an output.

```liquidsoap
settings.request.deprecated_on_air_metadata := false
```

### Methods to extract file duration.

```liquidsoap
settings.request.dresolvers := ["wav/aiff", "ffmpeg", "flac", "ogg_flac", "mad", "vorbis"]
```

### Number of requests at which a leak warning should be issued.

```liquidsoap
settings.request.leak_warning := 100
```

### Decoders and order used to decode files' metadata.

```liquidsoap
settings.request.metadata_decoders := ["video-metadata", "ogg_native", "image", "ID3", "ID3v1", "ID3v2", "flac_native", "mp4", "ffmpeg", "flac", "ogg"]
```

#### Compute duration in the "duration" metadata, if the metadata is not already present. This can take a long time and the use of this option is not recommended: the proper way is to have a script precompute the "duration" metadata.

```liquidsoap
settings.request.metadata_decoders.duration := false
```

#### Priorities used for applying metadata decoders. Decoder with the highest priority take precedence.

##### Priority for the ffmpeg metadata decoder

```liquidsoap
settings.request.metadata_decoders.priorities.ffmpeg := 1
```

##### Priority for the flac metadata decoder

```liquidsoap
settings.request.metadata_decoders.priorities.flac := 1
```

##### Priority for the flac native decoder

```liquidsoap
settings.request.metadata_decoders.priorities.flac_native := 1
```

##### Priority for the native ID3 metadata decoder

```liquidsoap
settings.request.metadata_decoders.priorities.id3 := 1
```

##### Priority for the native ID3v1 metadata decoder

```liquidsoap
settings.request.metadata_decoders.priorities.id3v1 := 1
```

##### Priority for the native ID3v2 metadata decoder

```liquidsoap
settings.request.metadata_decoders.priorities.id3v2 := 1
```

##### Priority for the image metadata decoder

```liquidsoap
settings.request.metadata_decoders.priorities.image_metadata := 1
```

##### Priority for the mp4 metadata decoder

```liquidsoap
settings.request.metadata_decoders.priorities.mp4 := 1
```

##### Priority for the ogg metadata decoder

```liquidsoap
settings.request.metadata_decoders.priorities.ogg := 1
```

##### Priority for the native ogg metadata decoder

```liquidsoap
settings.request.metadata_decoders.priorities.ogg_metadata := 1
```

##### Priority for the request metadata. This include metadata set via `annotate`.

```liquidsoap
settings.request.metadata_decoders.priorities.request_metadata := 5
```

##### Priority for the native video metadata decoder

```liquidsoap
settings.request.metadata_decoders.priorities.video_metadata := 1
```

#### Re-encode metadata strings in UTF-8

```liquidsoap
settings.request.metadata_decoders.recode := true
```

##### Exclude these metadata from automatic recording.

```liquidsoap
settings.request.metadata_decoders.recode.exclude := ["pic", "apic", "metadata_block_picture", "coverart"]
```

### Default prefetch

```liquidsoap
settings.request.prefetch := 1
```

### Default request resolution timeout.

```liquidsoap
settings.request.timeout := 29.0
```

## Runtime configuration.

### Strip runtime types whenever possible to optimize memory usage.

```liquidsoap
settings.runtime.strip_types := true
```

## Sandboxing for external processes.

```liquidsoap
settings.sandbox := false
```

### Sandbox binary to use.

```liquidsoap
settings.sandbox.binary := "bwrap"
```

### Enable network

```liquidsoap
settings.sandbox.network := true
```

### Read-only directories

```liquidsoap
settings.sandbox.ro := ["/"]
```

### Read/write directories. Default: `[$HOME;$TMPDIR]`.

```liquidsoap
settings.sandbox.rw := ["/var/cache/liquidsoap", "/tmp"]
```

### Additional default environment variables.

```liquidsoap
settings.sandbox.setenv := ["TEMPDIR=/tmp", "TEMP=/tmp", "TMPDIR=/tmp", "TMP=/tmp"]
```

### Run command inside shell.

```liquidsoap
settings.sandbox.shell := true
```

#### Patch to shell binary. Defaults to `$SHELL` if set and "/bin/sh" otherwise.

```liquidsoap
settings.sandbox.shell.path := "/bin/sh"
```

### Environment variables to unset.

```liquidsoap
settings.sandbox.unsetenv := []
```

## Internal scheduler

The scheduler is used to process various tasks in liquidsoap.There are three kinds of tasks:"Non-blocking" ones are instantaneous to process, these are onlyinternal processes of liquidsoap like its server."Fast" tasks are those that can be long but are often not,such as request resolution (audio file downloading and checking).Finally, "slow" tasks are those that are always taking a long time,like last.fm submission, or user-defined tasks register via`thread.run`.The scheduler consists in a number of queues that process incomingtasks. Some queues might only process some kinds of tasks so thatthey are more responsive.Having more queues often do not make the program faster in average,but affect mostly the order in which tasks are processed.

### Fast queues

Number of queues that are dedicated to fast tasks.It might be useful to create some if your request resolutions,or some user defined tasks (cf `thread.run`), aredelayed too much because of slow tasks blocking the generic queues,such as last.fm submissions or slow `thread.run` handlers.

```liquidsoap
settings.scheduler.fast_queues := 0
```

### Generic queues

Number of event queues accepting any kind of task.There should at least be one. Having more can be useful to make surethat trivial request resolutions (local files) are not delayedbecause of a stalled download. But N stalled download can blockN queues anyway.

```liquidsoap
settings.scheduler.generic_queues := 5
```

### Log scheduler messages

```liquidsoap
settings.scheduler.log := false
```

### Non-blocking queues

Number of queues dedicated to internal non-blocking tasks.These are only started if such tasks are needed.There should be at least one.

```liquidsoap
settings.scheduler.non_blocking_queues := 2
```

## SDL configuration

### Logging configuration

#### Application logging verbosity.

Set SDL application logging verbosityOne of: "verbose", "debug", "info", "warn", "error" or "critical".

```liquidsoap
settings.sdl.log.application := "warn"
```

#### Audio logging verbosity.

Set SDL audio logging verbosityOne of: "verbose", "debug", "info", "warn", "error" or "critical".

```liquidsoap
settings.sdl.log.audio := "warn"
```

#### Error logging verbosity.

Set SDL error logging verbosityOne of: "verbose", "debug", "info", "warn", "error" or "critical".

```liquidsoap
settings.sdl.log.error := "warn"
```

#### Input logging verbosity.

Set SDL input logging verbosityOne of: "verbose", "debug", "info", "warn", "error" or "critical".

```liquidsoap
settings.sdl.log.input := "warn"
```

#### Render logging verbosity.

Set SDL render logging verbosityOne of: "verbose", "debug", "info", "warn", "error" or "critical".

```liquidsoap
settings.sdl.log.render := "warn"
```

#### System logging verbosity.

Set SDL system logging verbosityOne of: "verbose", "debug", "info", "warn", "error" or "critical".

```liquidsoap
settings.sdl.log.system := "warn"
```

#### Video logging verbosity.

Set SDL video logging verbosityOne of: "verbose", "debug", "info", "warn", "error" or "critical".

```liquidsoap
settings.sdl.log.video := "warn"
```

## Server configuration

The server is an abstract text-command-based communication protocol, which can be used through several interfaces.

### Log configuration.

#### Default log level for messages.

```liquidsoap
settings.server.log.level := 3
```

### Support for communication via a UNIX domain socket interface

The main advantage of this method is that you can set very preciselythe access permissions for the socket, just like for any other file.A useful command to use this interface is: "socat stdin unix:<path>".

```liquidsoap
settings.server.socket := false
```

#### Path of the UNIX domain socket

In this filename, `<pid>`, `<script>` and `<sysrundir>` are replaced by their respective values: PID of the instance of liquidsoap,base name of the .liq script (if any), default runtime data directory.

```liquidsoap
settings.server.socket.path := "<sysrundir>/<script>.sock"
```

#### Socket permissions, up to umask

This parameter is better written in octal notation. Although you can write octal numbers like 0o660, they are not displayed back in octal. For example, the default value 384 is the decimal for 0o600.

```liquidsoap
settings.server.socket.permissions := 384
```

### Support for communication via a telnet interface

This allows you to communicate with the server via a telnet interface,i.e., a simple text-based communication over TCP.The standard "telnet" command will allow you to communicate throughthat interface, as well as the telnet libraries available in mostscript languages.Since there is currently no authentication, you should be carefulabout who can access this interface: either restrict it to connectionsfrom localhost (using the bind_addr param) or set up a firewall.

```liquidsoap
settings.server.telnet := false
```

#### Network mask from which the telnet server should accept connections

```liquidsoap
settings.server.telnet.bind_addr := "127.0.0.1"
```

#### Port on which the telnet server should listen

```liquidsoap
settings.server.telnet.port := 1234
```

#### Perform reverse DNS lookup to get the client's hostname from its IP.

```liquidsoap
settings.server.telnet.revdns := false
```

### Timeout for read/write operations.

A negative value disables timeout.

```liquidsoap
settings.server.timeout := 30.0
```

## SRT configuration

### Enforce consistent encryption settings on both end of any connection.

```liquidsoap
settings.srt.enforced_encryption := true
```

### Route srt logs through liquidsoap's logs

```liquidsoap
settings.srt.log := true
```

#### Level

```liquidsoap
settings.srt.log.level := 4
```

#### Verbosity

Set SRT log level, one of: "critical", "error", "warning", "notice" or "debug"

```liquidsoap
settings.srt.log.verbosity := "warning"
```

### Poll configuration

#### Timeout for polling loop, in seconda.

```liquidsoap
settings.srt.poll.timeout := 0.1
```

### Set preference for resolving addresses. One of: `"system"`, `"ipv4"` or `"ipv6"`.

```liquidsoap
settings.srt.prefer_address := "system"
```

## String settings

### Default encoding for `string.length`, `string.chars` and `string.sub`

```liquidsoap
settings.string.default_encoding := "utf8"
```

## Initialization configuration

### Allow liquidsoap to run as root

This should be reserved for advanced dynamic uses of liquidsoap such as running inside an isolated environment like docker.

```liquidsoap
settings.init.allow_root := false
```

### Catch exceptions, use false to backtrace exceptions

```liquidsoap
settings.init.catch_exn := true
```

### Run in daemon mode

```liquidsoap
settings.init.daemon := false
```

#### Changes the effective user (drops privileges).

```liquidsoap
settings.init.daemon.change_user := false
```

##### Group used to run the daemon.

```liquidsoap
settings.init.daemon.change_user.group := "daemon"
```

##### User used to run the daemon.

```liquidsoap
settings.init.daemon.change_user.user := "daemon"
```

#### Support for pidfile generation

```liquidsoap
settings.init.daemon.pidfile := true
```

##### Path to pidfile

```liquidsoap
settings.init.daemon.pidfile.path := "<sysrundir>/<script>.pid"
```

##### Unix file permissions for pidfile. Default: `0o640`.

```liquidsoap
settings.init.daemon.pidfile.perms := 416
```

### Start liquidsoap even without any active source

This should be reserved for advanced dynamic uses of liquidsoap.

```liquidsoap
settings.init.force_start := false
```

### Dump an initialization trace

```liquidsoap
settings.init.trace := false
```

### Run the OCaml memory compaction algorithm before starting your script. This is useful when script caching is not possible but initial memory consumption is a concern. This will result in a large chunk of memory being freed right before starting the script. This also increases the script's initial startup time.

```liquidsoap
settings.init.compact_before_start := true
```

## Playlist formats

### Cue in metadata for playlists with track index.

Some playlists format, such as CUE files specify index points to starttracks playback. In this case, tracks are resolved to a annotate: request witha cue-in metadata containing the index. If you want to make use of this index,you should specify here what label you want for this metadata.

```liquidsoap
settings.playlist.cue_in_metadata := "liq_cue_in"
```

### Cue out metadata for playlists with track index.

Some playlists format, such as CUE files specify index points to starttracks playback. In this case, tracks are resolved to a annotate: request witha cue-in metadata containing the index. If you want to make use of this index,you should specify here what label you want for this metadata.

```liquidsoap
settings.playlist.cue_out_metadata := "liq_cue_out"
```

### Settings for parsing cue files

#### Metadata used to pass pre-gap cue metadata

```liquidsoap
settings.playlist.cue.pregap_metadata := "liq_pregap"
```

#### Metadata used to pass index 0 cue metadata

```liquidsoap
settings.playlist.cue.index_zero_metadata := "liq_index_zero"
```

#### Metadata used to pass index 0 filename metadata

```liquidsoap
settings.playlist.cue.index_zero_filename_metadata := "liq_index_zero_filename"
```

#### Metadata used to pass pre-gap cue metadata

```liquidsoap
settings.playlist.cue.postgap_metadata := "liq_postgap"
```

### Mime-types used for guessing playlist formats.

#### Mime-types used for guessing text-based playlists.

```liquidsoap
settings.playlist.mime_types.basic := [{name="scpls format", mimes=["audio/x-scpls"], strict=true, parser=<fun>}, {name="cue sheet", mimes=["application/x-cue"], strict=true, parser=<fun>.{full=<fun>}}, {name="m3u Format", mimes=["audio/x-mpegurl", "audio/mpegurl", "application/x-mpegURL"], strict=false, parser=<fun>}]
```

#### Mime-types used for guessing xml-based playlists.

```liquidsoap
settings.playlist.mime_types.xml := [{name="xmlplaylist format", mimes=["video/x-ms-asf", "audio/x-ms-asx", "text/xml", "application/xml", "application/smil", "application/smil+xml", "application/xspf+xml", "application/rss+xml"], strict=true, parser=<fun>}]
```

## Settings for the amplify operator

### Default metadata used to override amplification.

```liquidsoap
settings.amplify.override := "liq_amplify"
```

## Metadata used to store track gain normalization metadata

```liquidsoap
settings.normalize_track_gain_metadata := "liq_normalize_track_gain"
```

## Settings for the fade in/out operators

### Settings for fade.in operators

#### Default fade.in duration

```liquidsoap
settings.fade.in.duration := 3.0
```

#### Default fade.in type

```liquidsoap
settings.fade.in.type := "lin"
```

#### Default fade.in curve

```liquidsoap
settings.fade.in.curve := 10.0
```

### Settings for fade.out operators

#### Default fade.out duration

```liquidsoap
settings.fade.out.duration := 3.0
```

#### Default fade.out type

```liquidsoap
settings.fade.out.type := "lin"
```

#### Default fade.out curve

```liquidsoap
settings.fade.out.curve := 10.0
```

## 

### All available autocue implementations

```liquidsoap
settings.autocue.implementations := [("internal", <fun>)]
```

### 

#### Priority for the autocue metadata resolver. Default value allows it to override both file and request metadata.

```liquidsoap
settings.autocue.metadata.priority := 10
```

### Preferred autocue

```liquidsoap
settings.autocue.preferred := "internal"
```

### How to proceed with loudness adjustment. Set to `"override"` to always prefer
      the value provided by the `autocue` provider. Set to `"ignore"` to ignore all
      loudness correction provided via the `autocue` provider. Set to
      `"keep"` to always prefer user-provided values (via request annotation or file tags)
      over values provided by the `autocue` provider.

```liquidsoap
settings.autocue.amplify_behavior := "override"
```

### List of metadata to treat as amplify aliases when applying the `amplify_behavior` policy.

```liquidsoap
settings.autocue.amplify_aliases := ["replaygain_track_gain"]
```

### 

#### Disable processing when one of these metadata is found

```liquidsoap
settings.autocue.internal.metadata_override := ["liq_cue_in", "liq_cue_out", "liq_fade_in", "liq_fade_in_delay", "liq_fade_out", "liq_fade_out_delay", "liq_disable_autocue"]
```

#### Loudness target

```liquidsoap
settings.autocue.internal.lufs_target := -14.0
```

#### Cue in threshold

```liquidsoap
settings.autocue.internal.cue_in_threshold := -34.0
```

#### Cue out threshold

```liquidsoap
settings.autocue.internal.cue_out_threshold := -42.0
```

#### Crossfade start threshold

```liquidsoap
settings.autocue.internal.cross_threshold := -7.0
```

#### Maximum allowed overlap/crossfade in seconds

```liquidsoap
settings.autocue.internal.max_overlap := 6.0
```

#### Try to optimize crossfade point on sustained endings

```liquidsoap
settings.autocue.internal.sustained_endings_enabled := true
```

#### Max. loudness drop off immediately after crossfade point to consider it as relevant ending [percentage]

```liquidsoap
settings.autocue.internal.sustained_endings_dropoff := 15.0
```

#### Max. loudness difference between crossfade point and cue out to consider it as relevant ending [percentage]

```liquidsoap
settings.autocue.internal.sustained_endings_slope := 20.0
```

#### Minimum duration to consider it the ending as sustained [seconds]

```liquidsoap
settings.autocue.internal.sustained_endings_min_duration := 1.0
```

#### Max reduction of dB thresholds compared to initial value [multiplying factor]

```liquidsoap
settings.autocue.internal.sustained_endings_threshold_limit := 2.0
```

#### Maximum real time ratio to control speed of LUFS data analysis

```liquidsoap
settings.autocue.internal.ratio := 70.0
```

#### Maximum allowed processing time (estimated)

```liquidsoap
settings.autocue.internal.timeout := 10.0
```

## 

### Target LUFS All available autocue implementations

```liquidsoap
settings.lufs.track_gain_target := -16.0
```

### Metadata used to store integrated LUFS

```liquidsoap
settings.lufs.integrated_metadata := "liq_integrated_lufs"
```

### Decoding ratio used when decoding integrated LUFS from files

```liquidsoap
settings.lufs.decoding_ratio := 50.0
```

## Settings for HTTP requests

### When `true`, HTTP urls are normalized by default, i.e. spaces are replaced with `%20` and etc.

```liquidsoap
settings.http.normalize_url := true
```

### MIME-related settings for HTTP requests

#### MIME to file extension mappings

```liquidsoap
settings.http.mime.extnames := [("application/mp4", ".mp4"), ("application/ogg", ".ogg"), ("application/pdf", ".pdf"), ("application/rss+xml", ".rss"), ("application/smil", ".smil"), ("application/smil+xml", ".smil"), ("application/x-cue", ".cue"), ("application/x-ogg", ".ogg"), ("application/xspf+xml", ".xspf"), ("audio/flac", ".flac"), ("audio/mp3", ".mp3"), ("audio/mp4", ".mp4"), ("audio/mpeg", ".mp3"), ("audio/mpegurl", ".m3u"), ("audio/ogg", ".ogg"), ("audio/vnd.wave", ".wav"), ("audio/wav", ".wav"), ("audio/wave", ".wav"), ("audio/x-flac", ".flac"), ("audio/x-mpegurl", ".m3u"), ("audio/x-ogg", ".ogg"), ("audio/x-scpls", ".pls"), ("audio/x-wav", ".wav"), ("image/bmp", ".bmp"), ("image/jpeg", ".jpg"), ("image/png", ".png"), ("text/plain", ".txt"), ("video/mp4", ".mp4"), ("video/ogg", ".ogg"), ("video/x-ms-asf", ".asf")]
```

## 

```liquidsoap
settings.make := <fun>.{protocol=<fun>, void=fun (~comments="",_) -> {comments=comments, description=description}}
```

### 

```liquidsoap
settings.make.void := fun (~comments="",_) -> {comments=comments, description=description}
```

### 

```liquidsoap
settings.make.protocol := <fun>
```

## Settings for registered protocols

### Settings for the process protocol

#### List of environment variables passed down to the executed process.

```liquidsoap
settings.protocol.process.env := []
```

#### Inherit calling process's environment when `env` parameter is empty.

```liquidsoap
settings.protocol.process.inherit_env := true
```

### Settings for the youtube-dl protocol

#### Path of the youtube-dl (or yt-dlp) binary.

```liquidsoap
settings.protocol.youtube_dl.path := "yt-dlp"
```

#### Timeout (in seconds) for youtube-dl executions.

```liquidsoap
settings.protocol.youtube_dl.timeout := 300.0
```

### Settings for the FFmpeg protocol

#### Path to the ffmpeg binary

```liquidsoap
settings.protocol.ffmpeg.path := "ffmpeg"
```

#### Should the protocol extract metadata

```liquidsoap
settings.protocol.ffmpeg.metadata := true
```

#### Should the protocol adjust ReplayGain

```liquidsoap
settings.protocol.ffmpeg.replaygain := false
```

### Settings for the text2wave protocol

#### Path to the text2wave binary

```liquidsoap
settings.protocol.text2wave.path := "text2wave"
```

### Settings for the pico2wave protocol

#### Path to the pico2wave binary

```liquidsoap
settings.protocol.pico2wave.path := "pico2wave"
```

#### Pico2wave language. One of: `"en-US"`, `"en-GB"`, `"es-ES"`, `"de-DE"`, `"fr-FR"` or `"it-IT"`.

```liquidsoap
settings.protocol.pico2wave.lang := "en-US"
```

### Settings for the gtts protocol

#### Path to the gtts binary

```liquidsoap
settings.protocol.gtts.path := "gtts-cli"
```

#### Language to speak in.

```liquidsoap
settings.protocol.gtts.lang := "en"
```

#### Command line options.

```liquidsoap
settings.protocol.gtts.options := ""
```

### Settings for the macos_say protocol

#### Path to the say binary

```liquidsoap
settings.protocol.macos_say.path := "say"
```

#### Command line options.

```liquidsoap
settings.protocol.macos_say.options := ""
```

### Settings for the say protocol

#### Implementation to use. One of: "pico2wave", "gtts", "text2wave" or "macos_say".

```liquidsoap
settings.protocol.say.implementation := "pico2wave"
```

### Settings for the AWS protocol

#### Use a specific profile from your credential file.

```liquidsoap
settings.protocol.aws.profile := <value>
```

#### Alternative endpoint URL (useful for other S3 implementations).

```liquidsoap
settings.protocol.aws.endpoint := <value>
```

#### AWS Region

```liquidsoap
settings.protocol.aws.region := <value>
```

#### Path to aws CLI binary

```liquidsoap
settings.protocol.aws.path := "aws"
```

#### Settings for the polly protocol

##### Output format

```liquidsoap
settings.protocol.aws.polly.format := "mp3"
```

##### Voice ID

```liquidsoap
settings.protocol.aws.polly.voice := "Joanna"
```

##### Extra command line arguments

```liquidsoap
settings.protocol.aws.polly.extra_args := []
```

## Video settings

Options related to video.

### Video conversion

Options related to video conversion.

#### Preferred video converter

```liquidsoap
settings.video.converter.preferred := "ffmpeg"
```

### `video.text` implementation.

```liquidsoap
settings.video.text := "sdl"
```

## Audioscrobbler settings

### Default API key for audioscrobbler

```liquidsoap
settings.audioscrobbler.api_key := ""
```

### Default API secret for audioscrobbler

```liquidsoap
settings.audioscrobbler.api_secret := ""
```
