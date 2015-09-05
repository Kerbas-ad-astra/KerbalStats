KSPDIR		:= ${HOME}/ksp/KSP_linux
MANAGED		:= ${KSPDIR}/KSP_Data/Managed
GAMEDATA	:= ${KSPDIR}/GameData
KSGAMEDATA  := ${GAMEDATA}/KerbalStats
PLUGINDIR	:= ${KSGAMEDATA}/Plugins

TARGETS		:= bin/KerbalStats.dll
DATA		:= \
	KerbalStatsWrapper.cs		\
	License.txt					\
	README.md					\
	Experience/seat_tasks.cfg	\
	$e

KS_FILES := \
	Experience/Body.cs				\
	Experience/Events.cs			\
	Experience/Experience.cs		\
	Experience/PartSeatTasks.cs		\
	Experience/SeatTasks.cs			\
	Experience/Task.cs				\
	Experience/Tracker.cs			\
	Genome/BadAss.cs				\
	Genome/Courage.cs				\
	Genome/Gender.cs				\
	Genome/GenePair.cs				\
	Genome/Genome.cs				\
	Genome/Probability.cs			\
	Genome/Stupidity.cs				\
	Genome/Trait.cs					\
	Profession/Profession.cs		\
	Progeny/AstronautComplex.cs		\
	Progeny/DebugWindow.cs			\
	Progeny/Embryo.cs				\
	Progeny/EVA.cs					\
	Progeny/Female.cs				\
	Progeny/IKerbal.cs				\
	Progeny/ILocation.cs			\
	Progeny/Init.cs					\
	Progeny/Juvenile.cs				\
	Progeny/LocationTracker.cs		\
	Progeny/Male.cs					\
	Progeny/Progeny.cs				\
	Progeny/Settings.cs				\
	Progeny/Tracker.cs				\
	Progeny/VesselPart.cs			\
	Progeny/Wilds.cs				\
	Progeny/Zygote.cs				\
	IKerbalExt.cs					\
	KerbalExt.cs					\
	KerbalStats.cs					\
	assembly/AssemblyInfo.cs		\
	assembly/VersionReport.cs		\
	toolbar/Toolbar.cs				\
	toolbar/ToolbarWrapper.cs		\
	$e

RESGEN2		:= resgen2
GMCS		:= gmcs
GMCSFLAGS	:= -optimize -warnaserror
GIT			:= git
TAR			:= tar
ZIP			:= zip

all: version ${TARGETS}

.PHONY: version
version:
	@./tools/git-version.sh

info:
	@echo "KerbalStats Build Information"
	@echo "    resgen2:    ${RESGEN2}"
	@echo "    gmcs:       ${GMCS}"
	@echo "    gmcs flags: ${GMCSFLAGS}"
	@echo "    git:        ${GIT}"
	@echo "    tar:        ${TAR}"
	@echo "    zip:        ${ZIP}"
	@echo "    KSP Data:   ${KSPDIR}"

bin/KerbalStats.dll: ${KS_FILES}
	@mkdir -p bin
	${GMCS} ${GMCSFLAGS} -t:library -lib:${MANAGED} \
		-r:Assembly-CSharp,Assembly-CSharp-firstpass,UnityEngine \
		-out:$@ $^

clean:
	rm -f ${TARGETS} assembly/AssemblyInfo.cs
	test -d bin && rmdir bin || true

install: all
	mkdir -p ${PLUGINDIR}
	cp ${TARGETS} ${PLUGINDIR}
	cp ${DATA} ${KSGAMEDATA}

.PHONY: all clean install
